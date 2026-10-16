defmodule PhoenixMultivitaminWeb.DakarHarmattanMetarHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 06 · Dakar harmattan METAR
      </p>

      <h1>Dakar harmattan METAR</h1>
      <p class="lede">
        Observer {@metar.observer} holds {@metar.dust} haze at {@metar.station}.
        This board is format <code>{@format_name}</code>.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="metar-station">{@metar.station}</dd>
        <dt>Weather</dt>
        <dd id="metar-weather">{@metar.weather}</dd>
        <dt>Format</dt>
        <dd id="metar-format">{@format_name}</dd>
        <dt>Observer</dt>
        <dd id="metar-observer">{@metar.observer}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/03-controllers-and-json/06-dakar-harmattan-metar"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
