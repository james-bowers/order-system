defmodule OrderSystemWeb.Router do
  use Plug.Router
  use Plug.Debugger
  alias OrderSystemWeb.{ProductRoute, AccountRoute, OrderRoute, PayRoute}

  plug(Plug.Logger)
  plug(OrderSystemWeb.Plug.FormatQueryString)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["text/*"],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  get "/status" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "OK")
  end

  forward("/product", to: ProductRoute)
  forward("/account", to: AccountRoute)
  forward("/order", to: OrderRoute)
  forward("/pay", to: PayRoute)

  get _ do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(404, "")
  end
end
