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

  @impl true
  def handle_in("stock_data:" <> company_id, payload, socket) do
    company_id = String.to_integer(company_id)
    # IO.put("compandyID = ✨ ", company_id)
    assign(socket, :company_id, company_id)
    :timer.send_interval(2_000, :ping_stock_data)
    {:noreply, socket}
  end

  @impl true
  def handle_info(:ping_stock_data, socket) do
    company_id = 8
    # IO.put("compandyID = ✨ ", company_id)
    data = Stock_exchange.get_company!(company_id)
    push(socket, "ping_stock_data", %{data: data.stock_prise})
    {:noreply, assign(socket, :company_id, company_id)}
    # {:noreply, assign(socket, :count, count + 1)}
  end

  # intercept ["new_msg"]

  @impl true
  def handle_out("new_msg", payload, socket) do
    push(socket, "new_msg", "macha")
    {:noreply, socket}
  end

  # @impl true
  # def handle_out("stock_data", payload, socket) do
  #   push(socket, "stock_data", "Sending data from server")
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

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

end
