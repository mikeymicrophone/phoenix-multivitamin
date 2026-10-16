defmodule PhoenixMultivitaminWeb.LehDensityAltitudeCardHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Controllers and JSON · 10 · Leh density-altitude card
      </p>

      <h1>Leh density-altitude card</h1>
      <p class="lede">
        Engineer {@engineer} trims the {@craft} on the high plateau. Post <code>card[oat_c]</code>
        and <code>card[elevation_ft]</code>.
      </p>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/03-controllers-and-json/10-leh-density-altitude-card"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
