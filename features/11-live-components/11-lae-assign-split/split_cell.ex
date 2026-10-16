# LiveComponents · 11 · Lae split cell
#
# Teaches:
# - The child owns taps; the parent owns the pad

defmodule PhoenixMultivitaminWeb.LaeSplitCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :taps, 0)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("tap_cell", _params, socket) do
    {:noreply, assign(socket, :taps, socket.assigns.taps + 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="cell-pad">{@pad}</p>
      <p id="cell-taps">{@taps}</p>
      <button id="tap-cell" type="button" phx-click="tap_cell" phx-target={@myself}>
        Tap cell
      </button>
    </div>
    """
  end
end
