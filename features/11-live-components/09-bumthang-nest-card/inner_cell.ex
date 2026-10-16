# LiveComponents · 09 · Bumthang inner cell
#
# Teaches:
# - The inner cell is its own LiveComponent

defmodule PhoenixMultivitaminWeb.BumthangInnerCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="inner-valley">{@valley}</p>
    </div>
    """
  end
end
