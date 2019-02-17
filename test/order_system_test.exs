defmodule OrderSystemWebTest do
  use ExUnit.Case
  use Plug.Test

  alias OrderSystemWeb.Router

  @opts Router.init([])

  test "/status" do
    conn = conn(:get, "/status")
    conn = Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert get_resp_header(conn, "content-type") == ["text/plain; charset=utf-8"]
    assert conn.resp_body == "OK"
  end
end
