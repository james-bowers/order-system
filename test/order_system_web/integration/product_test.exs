defmodule Test.OrderSystemWeb.Integration.Product do
  use Test.OrderSystem.DataCase
  use Plug.Test

  alias OrderSystemWeb.Router

  @opts Router.init([])

  @valid_attrs %{amount: 2500, title: "A product title", quantity: 50}
  @invalid_attrs %{quantity: 20}
  @product1_id "8ea46125-3d93-4858-bd14-c0de1f1a26cb"

  test "/product returns 200" do
    conn = conn(:post, "/product", @valid_attrs)
    conn = Router.call(conn, @opts)

    assert conn.status == 200, conn.resp_body

    String.contains?(conn.resp_body, ~s({"title":"A product title","id":))
  end

  test "/product returns 400 when invalid params given" do
    conn = conn(:post, "/product", @invalid_attrs)
    conn = Router.call(conn, @opts)

    assert conn.status == 400

    assert conn.resp_body ==
             ~s({"description":"Sorry, we have not created your product, as the request made was invalid.","content":{"changeset":{"title":["can't be blank"],"amount":["can't be blank"]},"action":"product"}})
  end

  test "/product/:product_id/available returns available quantity" do
    conn = conn(:get, "/product/#{@product1_id}/available")
    conn = Router.call(conn, @opts)

    assert conn.status == 200, conn.resp_body

    assert conn.resp_body ==
             ~s({"description":"Quantity of this product available for purchase.","content":3})
  end

  test "/product/:product_id/available with invalid product_id" do
    conn = conn(:get, "/product/foo/available")
    conn = Router.call(conn, @opts)

    assert conn.status == 400
    assert conn.resp_body == ~s({"description":"An invalid ID was provided.","content":null})
  end
end
