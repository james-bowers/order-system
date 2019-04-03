use Mix.Config

config :logger, level: :warn

config :order_system, OrderSystem.Repo,
  database: "order_system_repo",
  username: "postgres",
  password: "pass",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  port: "5432"
