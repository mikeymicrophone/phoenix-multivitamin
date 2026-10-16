# LiveComponents · 02 · Tobruk update cell
#
# Teaches:
# - update/2 runs on every parent assign, not only mount

defmodule PhoenixMultivitaminWeb.TobrukUpdateCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :update_count, 0)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:update_count, socket.assigns.update_count + 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="cell-stand">{@stand}</p>
      <p id="update-count">{@update_count}</p>
    </div>
    """
  end
end
