# LiveComponents · 05 · Coyhaique brief cell
#
# Teaches:
# - update/2 receives the brief the parent assigned after handle_info

defmodule PhoenixMultivitaminWeb.CoyhaiqueBriefCell do
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
      <p id="cell-brief">{@brief}</p>
    </div>
    """
  end
end
