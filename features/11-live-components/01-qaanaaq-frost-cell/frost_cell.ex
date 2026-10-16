# LiveComponents · 01 · Qaanaaq frost cell
#
# Teaches:
# - A stateful component keeps taps under its own id

defmodule PhoenixMultivitaminWeb.QaanaaqFrostCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :taps, 0)}
  end

  @impl true
  def handle_event("tap_frost", _params, socket) do
    {:noreply, assign(socket, :taps, socket.assigns.taps + 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="cell-clerk">{@clerk}</p>
      <p id="cell-craft">{@craft}</p>
      <p id="frost-taps">{@taps}</p>
      <button id="tap-frost" type="button" phx-click="tap_frost" phx-target={@myself}>
        Tap frost
      </button>
    </div>
    """
  end
end
