# LiveComponents · 08 · Karaganda QNH cell
#
# Teaches:
# - send_update/3 writes assigns without a parent re-render of the tree

defmodule PhoenixMultivitaminWeb.KaragandaQnhCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="cell-qnh">{@qnh}</p>
    </div>
    """
  end
end
