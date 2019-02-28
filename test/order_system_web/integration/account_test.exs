defmodule Test.OrderSystemWeb.Integration.Account do
  use Test.OrderSystem.DataCase
  use Plug.Test

  alias OrderSystemWeb.Router

  @opts Router.init([])

  test "/account returns 400 without title provided" do
    conn = conn(:post, "/account")
    conn = Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 400
  end

  test "/account returns 200" do
    conn = conn(:post, "/account", %{title: "a new account"})
    conn = Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
  end
end
