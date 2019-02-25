defmodule OrderSystemWeb.Router do
  use Plug.Router
  use Plug.Debugger

  plug(Plug.Logger, log: :debug)

  plug(:match)
  plug(:dispatch)
  plug(OrderSystem.Plug.FormatRequest)

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

  get _ do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(404, "")
  end
end
