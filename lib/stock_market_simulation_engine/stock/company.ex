defmodule StockMarketSimulationEngine.Stock.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :company_id, :string
    field :industry, :string
    field :name, :string
    field :stock_price, :decimal
    field :volatility, :decimal

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :stock_price, :company_id, :volatility, :industry])
    |> validate_required([:name, :stock_price, :company_id, :volatility, :industry])
    |> unique_constraint(:company_id)
    |> unique_constraint(:name)
  end
end
