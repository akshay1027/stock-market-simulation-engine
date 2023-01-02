defmodule StockMarketSimulationEngine.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :stock_price, :decimal
      add :company_id, :string
      add :volatility, :decimal
      add :industry, :string

      timestamps()
    end

    create unique_index(:companies, [:company_id])
    create unique_index(:companies, [:name])
  end
end
