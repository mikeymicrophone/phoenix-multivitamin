defmodule PhoenixMultivitaminWeb.QueenstownMetarDeskHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 01 · Queenstown METAR desk
      </p>

      <h1>Queenstown METAR desk</h1>
      <p class="lede">
        Observer {@metar.observer} posts NZQN for the King Air 200. This board is <code>render/3</code>. The export path is
        <code>json/2</code>
        on the same controller.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="metar-station">{@metar.station}</dd>
        <dt>Wind</dt>
        <dd id="metar-wind">{@metar.wind}</dd>
        <dt>Observer</dt>
        <dd id="metar-observer">{@metar.observer}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/03-controllers-and-json/01-queenstown-metar-desk"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
