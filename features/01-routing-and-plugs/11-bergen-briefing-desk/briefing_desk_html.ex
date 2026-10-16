defmodule PhoenixMultivitaminWeb.BergenBriefingDeskHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def roster(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 11 · Bergen briefing desk
      </p>

      <h1>Bergen briefing desk</h1>
      <p id="roster-banner" class="mount-banner static-mount">
        Sign the roster at {@station} before the SID plates come out of the
        drawer. Dispatcher Åse is on tonight.
      </p>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/11-bergen-briefing-desk"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end

  def desk(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 11 · Bergen briefing desk
      </p>

      <h1>Bergen briefing desk</h1>
      <p id="desk-banner" class="mount-banner">
        Dispatcher {@dispatcher} spreads {@plate} on the desk at {@station}.
      </p>

      <dl class="station-meta">
        <dt>Dispatcher</dt>
        <dd id="dispatcher-name">{@dispatcher}</dd>
        <dt>Plate</dt>
        <dd id="plate-name">{@plate}</dd>
        <dt>Plates opened</dt>
        <dd id="plates-opened">{if @plates_opened, do: "yes", else: "no"}</dd>
      </dl>
    </Layouts.catalog>
    """
  end
end
