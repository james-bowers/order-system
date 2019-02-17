defmodule OrderSystem.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(
        scheme: :http,
        plug: OrderSystemWeb.Router,
        options: [port: 8084, protocol_options: [max_keepalive: 5_000_000]]
      )
    ]

    opts = [strategy: :one_for_one, name: OrderSystemWeb.Router.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
