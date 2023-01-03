defmodule StockMarketSimulationEngine.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :industry, :string
      add :stock_prise, :decimal
      add :volatility, :decimal
      add :company_id, :string

      timestamps()
    end

    create unique_index(:companies, [:name])
  end
end
