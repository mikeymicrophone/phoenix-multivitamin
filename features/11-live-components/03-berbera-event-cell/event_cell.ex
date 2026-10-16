# LiveComponents · 03 · Berbera event cell
#
# Teaches:
# - handle_event/3 runs in the component, not the parent

defmodule PhoenixMultivitaminWeb.BerberaEventCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :stand, "none")}
  end

  @impl true
  def handle_event("park_south", _params, socket) do
    {:noreply, assign(socket, :stand, "south")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="cell-stand">{@stand}</p>
      <button id="park-south" type="button" phx-click="park_south" phx-target={@myself}>
        Park south
      </button>
    </div>
    """
  end
end
