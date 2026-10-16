# LiveView navigation · 13 · Rio Grande Fuegian relief
#
# Teaches:
# - The relief board is a different LiveView

defmodule PhoenixMultivitaminWeb.RioGrandeReliefBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Rio Grande Fuegian watch")
     |> assign(:clerk, "Belén")
     |> assign(:craft, "Beech 1900")
     |> assign(:clicks, 0)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 13 · Rio Grande Fuegian watch
      </p>

      <h1>Rio Grande Fuegian watch</h1>
      <p class="lede">
        Clerk {@clerk} has the {@craft} on the relief board. Fresh process.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="relief-clicks">{@clicks}</p>
      <p id="surface-name">relief</p>
    </Layouts.catalog>
    """
  end
end
