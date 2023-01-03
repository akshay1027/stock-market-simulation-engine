defmodule StockMarketSimulationEngine.Stock_exchangeTest do
  use StockMarketSimulationEngine.DataCase

  alias StockMarketSimulationEngine.Stock_exchange

  describe "companies" do
    alias StockMarketSimulationEngine.Stock_exchange.Company

    import StockMarketSimulationEngine.Stock_exchangeFixtures

    @invalid_attrs %{company_id: nil, industry: nil, name: nil, stock_prise: nil, volatility: nil}

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Stock_exchange.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Stock_exchange.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      valid_attrs = %{company_id: "some company_id", industry: "some industry", name: "some name", stock_prise: "120.5", volatility: "120.5"}

      assert {:ok, %Company{} = company} = Stock_exchange.create_company(valid_attrs)
      assert company.company_id == "some company_id"
      assert company.industry == "some industry"
      assert company.name == "some name"
      assert company.stock_prise == Decimal.new("120.5")
      assert company.volatility == Decimal.new("120.5")
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stock_exchange.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      update_attrs = %{company_id: "some updated company_id", industry: "some updated industry", name: "some updated name", stock_prise: "456.7", volatility: "456.7"}

      assert {:ok, %Company{} = company} = Stock_exchange.update_company(company, update_attrs)
      assert company.company_id == "some updated company_id"
      assert company.industry == "some updated industry"
      assert company.name == "some updated name"
      assert company.stock_prise == Decimal.new("456.7")
      assert company.volatility == Decimal.new("456.7")
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Stock_exchange.update_company(company, @invalid_attrs)
      assert company == Stock_exchange.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Stock_exchange.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Stock_exchange.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Stock_exchange.change_company(company)
    end
  end
end
