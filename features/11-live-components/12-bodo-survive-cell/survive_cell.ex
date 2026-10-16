# LiveComponents · 12 · Bodø survive cell
#
# Teaches:
# - The same id keeps mount from running again

defmodule PhoenixMultivitaminWeb.BodoSurviveCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :mounts, 1)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="cell-mounts">{@mounts}</p>
    </div>
    """
  end
end
