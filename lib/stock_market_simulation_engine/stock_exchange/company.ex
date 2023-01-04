defmodule StockMarketSimulationEngine.Stock_exchange.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :company_id, :string
    field :industry, :string
    field :name, :string
    field :stock_prise, :decimal
    field :volatility, :decimal

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :industry, :stock_prise, :volatility])
    |> validate_required([:name, :industry, :stock_prise, :volatility])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 2, max: 100)
  end
end
