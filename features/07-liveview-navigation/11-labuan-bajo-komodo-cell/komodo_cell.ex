# LiveView navigation · 11 · Labuan Bajo Komodo cell
#
# Teaches:
# - The cell does not patch itself
# - It sends the stand to the parent LiveView

defmodule PhoenixMultivitaminWeb.LabuanBajoKomodoCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def handle_event("open_stand", %{"stand" => stand}, socket) do
    send(self(), {:open_stand, stand})
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="cell-clerk">{@clerk}</p>
      <p id="cell-craft">{@craft}</p>
      <button
        id="open-rinca"
        type="button"
        phx-click="open_stand"
        phx-value-stand="rinca"
        phx-target={@myself}
      >
        Open Rinca
      </button>
    </div>
    """
  end
end
