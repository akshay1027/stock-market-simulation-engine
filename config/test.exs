import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :stock_market_simulation_engine, StockMarketSimulationEngine.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "stock_market_simulation_engine_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stock_market_simulation_engine, StockMarketSimulationEngineWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "iUO095SX+z2an4cX5Ck+KXb2pOa2jfRRrg7x9hY0HFeqkieoyA/nSH5SkhJNfNcM",
  server: false

# In test we don't send emails.
config :stock_market_simulation_engine, StockMarketSimulationEngine.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
