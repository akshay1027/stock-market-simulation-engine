defmodule StockMarketSimulationEngine.StockFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StockMarketSimulationEngine.Stock` context.
  """

  @doc """
  Generate a unique company company_id.
  """
  def unique_company_company_id, do: "some company_id#{System.unique_integer([:positive])}"

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
        company_id: unique_company_company_id(),
        industry: "some industry",
        name: unique_company_name(),
        stock_price: "120.5",
        volatility: "120.5"
      })
      |> StockMarketSimulationEngine.Stock.create_company()

    company
  end
end
