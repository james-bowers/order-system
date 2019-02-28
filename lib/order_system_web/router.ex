defmodule OrderSystemWeb.Router do
  use Plug.Router
  use Plug.Debugger
  use Plug.ErrorHandler
  alias OrderSystemWeb.Controller.Account

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)
  plug(OrderSystem.Plug.FormatQueryString)
  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["text/*"],
    json_decoder: Poison
  )

  get "/status" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "OK")
  end

  post "/account", do: Account.new(conn)

  get _ do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(404, "")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
