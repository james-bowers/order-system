use Mix.Config

config :order_system, OrderSystem.Repo,
  database: "order_system_repo",
  username: "postgres",
  password: "pass",
  pool: Ecto.Adapters.SQL.Sandbox,
  hostname: "db",
  port: "5432"
