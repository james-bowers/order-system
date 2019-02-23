use Mix.Config

config :logger, level: :warn

config :order_system, OrderSystem.Repo,
  database: "order_system_repo",
  username: "postgres",
  password: "pass",
  # change hostname to db, when github actions supports `docker-compose run test`
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
