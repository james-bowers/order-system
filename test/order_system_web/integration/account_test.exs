defmodule Test.OrderSystemWeb.Integration.Account do
  use Test.OrderSystem.DataCase
  use Plug.Test

  alias OrderSystemWeb.Router

  @opts Router.init([])

  @valid_attrs %{title: "Account title"}

  describe "creates an account" do
    test "/account returns 200 with provided account title" do
      conn = conn(:post, "/account", @valid_attrs)
      conn = Router.call(conn, @opts)
  
      assert conn.status == 200, conn.resp_body
      assert String.contains?(conn.resp_body, ~s({"description":"A new account has been created.","content":{"title":"Account title","id":))
    end
    
    test "/account anonymous account" do
      conn = conn(:post, "/account", %{})
      conn = Router.call(conn, @opts)
  
      assert conn.status == 200, conn.resp_body
      assert String.contains?(conn.resp_body, ~s({"description":"A new account has been created.","content":{"title":null,"id":))
    end
  end
end
