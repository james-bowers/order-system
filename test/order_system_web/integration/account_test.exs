defmodule Test.OrderSystemWeb.Integration.Account do
  use Test.OrderSystem.DataCase
  use Plug.Test

  alias OrderSystemWeb.Router

  @opts Router.init([])
  @account1_id "7f68c8ee-882b-4512-bd73-a7c2147e5f77"
  @account3_id "eacb49e9-221e-488e-9e6d-a6fb529d5f4b"

  test "/account returns 400 without title provided" do
    conn = conn(:post, "/account")
    conn = Router.call(conn, @opts)

    assert conn.status == 400
    assert conn.resp_body == ~s({"title":["can't be blank"]})
  end

  test "/account returns 200" do
    conn = conn(:post, "/account", %{title: "a new account"})
    conn = Router.call(conn, @opts)

    assert conn.status == 200
    assert String.contains?(conn.resp_body, ~s("title":"a new account"))
  end

  test "retrieves an account" do
    conn = conn(:get, "/account/#{@account1_id}")
    conn = Router.call(conn, @opts)

    assert conn.status == 200
    assert conn.resp_body == ~s({"title":"seed account title","id":"#{@account1_id}"})
  end

  test "retrieves balance of an account" do
    conn = conn(:get, "/account/#{@account1_id}/balance")
    conn = Router.call(conn, @opts)

    assert conn.status == 200
    assert conn.resp_body == ~s({"balance":1500})
  end

  test "fails to get balance of invalid account id" do
    conn = conn(:get, "/account/foo-bar/balance")
    conn = Router.call(conn, @opts)

    assert conn.status == 400
    assert conn.resp_body == ~s({"error":"Invalid Id"})
  end

  test "retrieves account transfer history" do
    conn = conn(:get, "/account/#{@account3_id}/transfer-history")
    conn = Router.call(conn, @opts)

    assert conn.status == 200

    expected_resp_body =
      json_response(%{
        history: [
          %{
            amount: 1000,
            transfered_at: "2019-02-22T16:59:38"
          },
          %{
            amount: 3000,
            transfered_at: "2019-02-22T16:59:39"
          },
          %{
            amount: -2000,
            transfered_at: "2019-02-22T16:59:40"
          }
        ]
      })

    assert conn.resp_body == expected_resp_body
  end

  test "get products an account has sold" do
    account1_id = "7f68c8ee-882b-4512-bd73-a7c2147e5f77"
    conn = conn(:get, "/account/#{account1_id}/sold-products")
    conn = Router.call(conn, @opts)

    expected_response =
      json_response(%{
        sold_products: [
          %{
            title: "A seed data product title",
            product_id: "8ea46125-3d93-4858-bd14-c0de1f1a26cb"
          }
        ]
      })

    assert conn.status == 200
    assert conn.resp_body == expected_response
  end
end
