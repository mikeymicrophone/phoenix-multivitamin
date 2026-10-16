# LiveComponents · 12 · Bodø survive cell
#
# Teaches:
# - A component that survives a parent re-render

defmodule PhoenixMultivitaminWeb.BodoSurviveCellLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.BodoSurviveCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Bodø survive cell")
     |> assign(:clerk, "Sigrid")
     |> assign(:craft, "Lockheed P-3 Orion")
     |> assign(:ticks, 0)}
  end

  @impl true
  def handle_event("tick_parent", _params, socket) do
    {:noreply, assign(socket, :ticks, socket.assigns.ticks + 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 12 · Bodø survive cell
      </p>

      <h1>Bodø survive cell</h1>
      <p class="lede">
        Clerk {@clerk} ticks the {@craft} parent. The cell keeps the same id
        and does not remount.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="parent-ticks">{@ticks}</p>

      <button id="tick-parent" type="button" phx-click="tick_parent">
        Tick parent
      </button>

      <.live_component module={BodoSurviveCell} id="survive-cell" />
    </Layouts.catalog>
    """
  end
end
