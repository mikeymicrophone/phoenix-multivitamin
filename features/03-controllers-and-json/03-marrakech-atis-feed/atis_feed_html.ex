defmodule PhoenixMultivitaminWeb.MarrakechAtisFeedHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 03 · Marrakech ATIS feed
      </p>

      <h1>Marrakech ATIS feed</h1>
      <p class="lede">
        Clerk {@atis.clerk} holds information {@atis.info} at {@atis.station}.
        Posts go to the same controller; a short info line is the fallback.
      </p>

      <dl class="station-meta">
        <dt>Info</dt>
        <dd id="atis-info">{@atis.info}</dd>
        <dt>Wind</dt>
        <dd id="atis-wind">{@atis.wind}</dd>
        <dt>Clerk</dt>
        <dd id="atis-clerk">{@atis.clerk}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/03-controllers-and-json/03-marrakech-atis-feed"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
