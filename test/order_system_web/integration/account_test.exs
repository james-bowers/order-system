defmodule Test.OrderSystemWeb.Integration.Account do
  use Test.OrderSystem.DataCase
  use Plug.Test

  alias OrderSystemWeb.Router

  @opts Router.init([])

  @valid_attrs %{title: "Account title"}
  @account3_id "eacb49e9-221e-488e-9e6d-a6fb529d5f4b"

  describe "creates an account" do
    test "/account returns 200 with provided account title" do
      conn = conn(:post, "/account", @valid_attrs)
      conn = Router.call(conn, @opts)

      assert conn.status == 200, conn.resp_body

      assert String.contains?(
               conn.resp_body,
               ~s({"description":"A new account has been created.","content":{"title":"Account title","id":)
             )
    end

    test "/account anonymous account" do
      conn = conn(:post, "/account", %{})
      conn = Router.call(conn, @opts)

      assert conn.status == 200, conn.resp_body

      assert String.contains?(
               conn.resp_body,
               ~s({"description":"A new account has been created.","content":{"title":null,"id":)
             )
    end
  end

  describe "transfer history" do
    test "returns an empty list for non-existant account" do
      unused_id = "9eef8422-d07d-4ecb-9825-00e60bc8b5c4"
      conn = conn(:get, "/account/#{unused_id}/transfers")
      conn = Router.call(conn, @opts)

      assert conn.status == 200, conn.resp_body
      assert conn.resp_body == ~s({"description":"Transfer history for an account.","content":[]})
    end
    
    test "returns account balance" do
      conn = conn(:get, "/account/#{@account3_id}/balance")
      conn = Router.call(conn, @opts)

      assert conn.status == 200, conn.resp_body
      assert conn.resp_body == ~s({"description":"The account's current balance.","content":2000})
    end

    test "account balance for an invalid account id" do
      conn = conn(:get, "/account/foo/balance")
      conn = Router.call(conn, @opts)

      assert conn.status == 400, conn.resp_body
    end
        
    test "account balance for non existent account" do
      conn = conn(:get, "/account/e308f1f4-f66d-4c60-a7c3-669596797cba/balance")
      conn = Router.call(conn, @opts)

      assert conn.status == 404, conn.resp_body
      assert conn.resp_body == ~s({"description":"The account could not be found.","content":null})
    end

    test "returns account's transfer history" do
      conn = conn(:get, "/account/#{@account3_id}/transfers")
      conn = Router.call(conn, @opts)

      assert conn.status == 200, conn.resp_body

      assert conn.resp_body ==
               ~s({"description":"Transfer history for an account.","content":[{"transfered_at":"2019-02-22T16:59:38","amount":1000},{"transfered_at":"2019-02-22T16:59:39","amount":3000},{"transfered_at":"2019-02-22T16:59:40","amount":-2000}]})
    end

    test "errors for an invalid account id" do
      conn = conn(:get, "/account/foo/transfers")
      conn = Router.call(conn, @opts)

      assert conn.status == 400, conn.resp_body
      assert conn.resp_body == ~s({"description":"An invalid ID was provided.","content":null})
    end
  end
end
