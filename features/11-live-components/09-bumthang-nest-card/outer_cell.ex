# LiveComponents · 09 · Bumthang outer cell
#
# Teaches:
# - A component nested inside another component

defmodule PhoenixMultivitaminWeb.BumthangOuterCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  alias PhoenixMultivitaminWeb.BumthangInnerCell

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="outer-clerk">{@clerk}</p>
      <.live_component module={BumthangInnerCell} id="inner-cell" valley={@valley} />
    </div>
    """
  end
end
