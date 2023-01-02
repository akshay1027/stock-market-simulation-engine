defmodule StockMarketSimulationEngine.Repo do
  use Ecto.Repo,
    otp_app: :stock_market_simulation_engine,
    adapter: Ecto.Adapters.Postgres
end
