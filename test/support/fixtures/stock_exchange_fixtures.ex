defmodule StockMarketSimulationEngine.Stock_exchangeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StockMarketSimulationEngine.Stock_exchange` context.
  """

  @doc """
  Generate a unique company name.
  """
  def unique_company_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        company_id: "some company_id",
        industry: "some industry",
        name: unique_company_name(),
        stock_prise: "120.5",
        volatility: "120.5"
      })
      |> StockMarketSimulationEngine.Stock_exchange.create_company()

    company
  end
end
