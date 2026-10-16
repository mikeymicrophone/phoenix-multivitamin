# LiveView navigation · 02 · Rovaniemi aurora desk
#
# Teaches:
# - navigate/2 mounts a different LiveView
# - The desk process does not survive the cabin

defmodule PhoenixMultivitaminWeb.RovaniemiAuroraDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Rovaniemi aurora desk")
     |> assign(:clerk, "Aino")
     |> assign(:craft, "ATR 72")
     |> assign(:clicks, 0)}
  end

  @impl true
  def handle_event("tick_desk", _params, socket) do
    {:noreply, assign(socket, :clicks, socket.assigns.clicks + 1)}
  end

  def handle_event("open_cabin", _params, socket) do
    {:noreply,
     push_navigate(socket,
       to: ~p"/features/07-liveview-navigation/02-rovaniemi-aurora-desk/cabin"
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 02 · Rovaniemi aurora desk
      </p>

      <h1>Rovaniemi aurora desk</h1>
      <p class="lede">
        Clerk {@clerk} keeps the {@craft} aurora desk. Opening the cabin mounts
        a different LiveView. Desk clicks do not travel.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="desk-clicks">{@clicks}</p>
      <p id="surface-name">desk</p>

      <button id="tick-desk" type="button" phx-click="tick_desk">Tick desk</button>
      <button id="open-cabin" type="button" phx-click="open_cabin">Open cabin</button>
    </Layouts.catalog>
    """
  end
end
