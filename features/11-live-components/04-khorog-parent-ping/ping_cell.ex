# LiveComponents · 04 · Khorog ping cell
#
# Teaches:
# - send/2 from the child reaches the parent LiveView

defmodule PhoenixMultivitaminWeb.KhorogPingCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def handle_event("ping_parent", _params, socket) do
    send(self(), {:khorog_ping, "Gunt ridge"})
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <button id="ping-parent" type="button" phx-click="ping_parent" phx-target={@myself}>
        Ping parent
      </button>
    </div>
    """
  end
end
