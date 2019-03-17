defmodule Test.OrderSystemWeb.Integration.Order do
  use Test.OrderSystem.DataCase
  use Plug.Test

  alias OrderSystemWeb.Router

  @opts Router.init([])

  @order1_id "b03f40b3-5aa8-40f4-92c0-e0bf9d723c3c"

  @product1_id "8ea46125-3d93-4858-bd14-c0de1f1a26cb"
  @product2_id "1fe4bc96-dca7-47cf-856c-7535a012df1d"

  @valid_body %{
    items: [
      %{
        product_id: @product1_id,
        quantity: 3
      },
      %{
        product_id: @product2_id,
        quantity: 1
      }
    ]
  }

  @exceed_qty_body %{
    items: [
      %{
        product_id: @product1_id,
        quantity: 4
      },
      %{
        product_id: @product2_id,
        quantity: 1
      }
    ]
  }

  describe "successful" do
    test "/order" do
      conn = conn(:post, "/order", @valid_body)
      conn = Router.call(conn, @opts)

      assert conn.status == 200, conn.resp_body
      assert String.contains?(conn.resp_body, ~s("id":))

      assert String.contains?(
               conn.resp_body,
               ~s("description":"A new order has been registered.")
             )
    end
  end

  describe "unsuccessful" do
    test "/order" do
      conn = conn(:post, "/order", @exceed_qty_body)
      conn = Router.call(conn, @opts)

      assert conn.status == 400, conn.resp_body

      assert String.contains?(
               conn.resp_body,
               ~s("description":"There are not enough available items to process your request.")
             )
    end
  end

  test "fetch an order" do
    conn = conn(:get, "/order/#{@order1_id}")
    conn = Router.call(conn, @opts)

    assert conn.status == 200, conn.resp_body

    assert conn.resp_body ==
             ~s({"description":"Items in the requested order.","content":[{"title":"A seed data product title","item_id":"b4c0fb72-e4b0-47fb-958f-20c0a831a2dc","amount":3000},{"title":"A seed data product title","item_id":"9c3be15f-5051-416d-a503-1fddf9bff65c","amount":3000}]})
  end

  test "fetch an order - with invalid id" do
    conn = conn(:get, "/order/foo")
    conn = Router.call(conn, @opts)

    assert conn.status == 400, conn.resp_body
    assert conn.resp_body == ~s({"description":"An invalid ID was provided.","content":null})
  end

  test "fetch an order - with unknown id" do
    conn = conn(:get, "/order/5f6b2512-5926-4437-8d0a-ea0f96ff838e")
    conn = Router.call(conn, @opts)

    assert conn.status == 404, conn.resp_body
    assert conn.resp_body == ~s({"description":"No order with that ID was found.","content":null})
  end
end
