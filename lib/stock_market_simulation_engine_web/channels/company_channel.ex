defmodule StockMarketSimulationEngineWeb.CompanyChannel do
  use StockMarketSimulationEngineWeb, :channel

  # Intial connection establishment between client and websocket server
  @impl true
  def join("company:lobby", payload, socket) do
    if authorized?(payload) do
      # {:ok, %{message: "success", mapla: "machi"}, socket}
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (company:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    Stream.iterate(0, &(&1+1))
      |> Enum.reduce_while(0, fn i, acc ->
      if i > 6 do
        broadcast(socket, "shout", payload)
        {:noreply, socket}
      else
        {:noreply, %{reason: "over"}}
      end
    end)
    # if (true) do
    #   broadcast(socket, "shout", payload)
    #   {:noreply, socket}
    # else
    #   {:noreply, %{reason: "over"}}
    # end
    # if infinityLoop?(0) do
    #   broadcast(socket, "shout", payload)
    #   {:noreply, socket}
    # else
    #   {:noreply, %{reason: "over"}}
    # end
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

  defp infinityLoop?(counter) do
    if (something_happens_here?()) do
      counter
    else
      infinityLoop?(counter+1)
    end
  end

  defp something_happens_here?() do
    true
  end

end
