# LiveComponents · 11 · Lae assign split
#
# Teaches:
# - Assigns the parent owns versus assigns the child owns

defmodule PhoenixMultivitaminWeb.LaeAssignSplitLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.LaeSplitCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Lae assign split")
     |> assign(:clerk, "Kila")
     |> assign(:craft, "Fokker F27")
     |> assign(:pad, "north")}
  end

  @impl true
  def handle_event("swing_south", _params, socket) do
    {:noreply, assign(socket, :pad, "south")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 11 · Lae assign split
      </p>

      <h1>Lae assign split</h1>
      <p class="lede">
        Clerk {@clerk} owns the {@craft} pad. The cell owns its taps. A pad
        swing does not reset the taps.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="swing-south" type="button" phx-click="swing_south">
        Swing south
      </button>

      <.live_component module={LaeSplitCell} id="split-cell" pad={@pad} />
    </Layouts.catalog>
    """
  end
end
