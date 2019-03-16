defmodule Test.OrderSystemWeb.Integration.Order do
  use Test.OrderSystem.DataCase
  use Plug.Test

  alias OrderSystemWeb.Router

  @opts Router.init([])

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
end
