# Verified routes · 04 · Turn Point light book
#
# Teaches:
# - ~p"/images/..." is a static path: the statics prefix, not a router route
# - Static ~p calls Endpoint.static_path/1; it does not add a digest until phx.digest
# - A missing file under a static prefix does not warn as "no route path"
# - favicon.ico and robots.txt are listed in static_paths/0 so ~p accepts them

defmodule PhoenixMultivitaminWeb.TurnPointLightBookLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    plate = ~p"/images/logo.svg"
    favicon = ~p"/favicon.ico"
    robots = ~p"/robots.txt"

    {:ok,
     socket
     |> assign(:page_title, "Turn Point light book")
     |> assign(:station, "Turn Point Light")
     |> assign(:keeper, "Selene")
     |> assign(:plate_path, plate)
     |> assign(:favicon_path, favicon)
     |> assign(:robots_path, robots)
     |> assign(:static_path, static_path(PhoenixMultivitaminWeb.Endpoint, "/images/logo.svg"))
     |> assign(
       :plate_integrity,
       static_integrity(PhoenixMultivitaminWeb.Endpoint, "/images/logo.svg")
     )}
  end

  def book_path, do: ~p"/features/02-verified-routes/04-turn-point-light-book"

  def characteristic_plate_path, do: ~p"/images/logo.svg"

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 04 · Turn Point light book
      </p>

      <h1>Turn Point light book</h1>
      <p class="lede">
        Keeper {@keeper} copies the characteristic plate for {@station} on
        Stuart Island. The plate, the station favicon, and robots.txt are
        static ~p paths, not router routes.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Plate ~p</dt>
        <dd id="plate-path">{@plate_path}</dd>
        <dt>Plate static_path</dt>
        <dd id="plate-static-path">{@static_path}</dd>
        <dt>Plate integrity</dt>
        <dd id="plate-integrity">{inspect(@plate_integrity)}</dd>
        <dt>Favicon</dt>
        <dd id="favicon-path">{@favicon_path}</dd>
        <dt>Robots</dt>
        <dd id="robots-path">{@robots_path}</dd>
      </dl>

      <div class="scenario">
        <h2>Characteristic plate</h2>
        <p id="plate-copy">Oc W 10s, 34 ft, 8 nm — copied from the light book plate.</p>
        <img
          id="characteristic-plate"
          src={@plate_path}
          alt="Turn Point characteristic plate"
          width="72"
          height="72"
        />
      </div>
    </Layouts.catalog>
    """
  end
end
