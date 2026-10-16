# LiveComponents · 07 · Samos stateless plate
#
# Teaches:
# - A LiveComponent that only renders still needs an id

defmodule PhoenixMultivitaminWeb.SamosStatelessPlate do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id="plate-clerk">{@clerk}</p>
      <p id="plate-craft">{@craft}</p>
      <p id="plate-qnh">{@qnh}</p>
    </div>
    """
  end
end
