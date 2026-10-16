# LiveComponents · 10 · Rankin Inlet myself cell
#
# Teaches:
# - @myself is a CID; self() is the parent pid

defmodule PhoenixMultivitaminWeb.RankinInletMyselfCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :stamp, "none")}
  end

  @impl true
  def handle_event("stamp_self", _params, socket) do
    {:noreply, assign(socket, :stamp, "myself")}
  end

  def handle_event("ping_parent", _params, socket) do
    send(self(), {:cell_pid, :parent})
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="cell-stamp">{@stamp}</p>
      <button id="stamp-self" type="button" phx-click="stamp_self" phx-target={@myself}>
        Stamp myself
      </button>
      <button id="ping-parent" type="button" phx-click="ping_parent" phx-target={@myself}>
        Ping parent
      </button>
    </div>
    """
  end
end
