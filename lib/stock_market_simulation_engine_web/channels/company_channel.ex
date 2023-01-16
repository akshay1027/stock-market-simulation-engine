defmodule StockMarketSimulationEngineWeb.CompanyChannel do
  use StockMarketSimulationEngineWeb, :channel
  alias StockMarketSimulationEngine.Stock_exchange

  # Intial connection establishment between client and websocket server
  @impl true
  def join("company:lobby", payload, socket) do
    if authorized?(payload) do
        {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Main function, handles company_id, makes DB request, starts timer, assigns keys to socket
  @impl true
  def handle_in("stock_data:" <> company_id, payload, socket) do
    company_id = String.to_integer(company_id)
    data = Stock_exchange.get_company!(company_id)

    socket = assign(socket, :stock_prise, data.stock_prise)
    socket = assign(socket, :volatility, data.volatility)

    :timer.send_interval(2_000, :ping_stock_data)

    {:noreply, socket}
  end

  # Pushing stock_prise to client using algorithm
  @impl true
  def handle_info(:ping_stock_data, socket) do
    stock_prise = stock_prise_algorithm(socket.assigns[:stock_prise], socket.assigns[:volatility])

    push(socket, "ping_stock_data", %{data: stock_prise})
    {:noreply, assign(socket, :stock_prise, socket.assigns[:stock_prise])}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  # Stock prise algorithm
  defp stock_prise_algorithm(stock_prise, volatility) do
    random_number = Enum.random(-9..9)
    variation_value = Decimal.mult(volatility, (random_number))
    stock_prise = Decimal.to_float(stock_prise) + Decimal.to_float(variation_value)
  end
end

#-------------------- DEVELOPMENT CODE: Uncommenting these and storing them so that i can remeber how i arrived at the above code. -----------------------------

  # @impl true
  # def handle_in("shout", payload, socket) do
  #   # randomNumber = :rand.uniform(1) |> Float.round(2)
  #   :timer.send_interval(2_000, :ping)
  #   # broadcast(socket, "shout", payload)
  #   {:noreply, socket}
  # end

  # @impl true
  # def handle_info(:ping, socket) do
  #   count = socket.assigns[:count] || 1
  #   push(socket, "ping", %{count: count})
  #   {:noreply, assign(socket, :count, count + 1)}
  # end

# @impl true
# def handle_info(:ping_stock_data, socket) do
  # IO.put("compandyID = ✨ ", socket.assigns.volatility)
  # {:noreply, assign(socket, :count, count + 1)}
    # company_id = 8
    # IO.put("compandyID = ✨ ", company_id)
    # data = Stock_exchange.get_company!(company_id)
    # random_number = :rand.uniform(9)
    # random_number = Enum.random(-9..9)
    # # IO.put("compandyID = ✨ ", random_number)
    # variation_value = Decimal.mult(socket.assigns[:volatility], (random_number))
    # stock_prise = Decimal.to_float(socket.assigns[:stock_prise]) + Decimal.to_float(variation_value)
    # push(socket, "ping_stock_data", %{data: stock_prise})
    # {:noreply, assign(socket, :stock_prise, socket.assigns[:stock_prise])}
        # {:noreply, assign(socket, :count, count + 1)}
# end

  # intercept ["new_msg"]

  # @impl true
  # def handle_out("stock_data", payload, socket) do
  #   push(socket, "stock_data", "Sending data from server")
  #   {:noreply, socket}
  # end

  # defp infinityLoop?(counter) do
  #   if (something_happens_here?()) do
  #     counter
  #   else
  #     infinityLoop?(counter+1)
  #   end
  # end

  # defp something_happens_here?() do
  #   true
  # end

    # @impl true
  # def handle_out("new_msg", payload, socket) do
  #   push(socket, "new_msg", "macha")
  #   {:noreply, socket}
  # end
