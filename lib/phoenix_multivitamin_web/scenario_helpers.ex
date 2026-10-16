defmodule PhoenixMultivitaminWeb.ScenarioHelpers do
  @moduledoc "Shared presentation setup; scenario content stays in the feature folders."
  use Phoenix.Component

  def assign_scenario(socket, title, clerk, craft) do
    assign(socket, page_title: title, clerk: clerk, craft: craft)
  end

  attr :clerk, :string, required: true
  attr :craft, :string, required: true

  def scenario_identity(assigns) do
    ~H"""
    <p id="clerk-name">{@clerk}</p>
    <p id="craft-name">{@craft}</p>
    """
  end
end
