# Verified routes · 08 · Mataveri METAR drum
#
# Teaches:
# - url(~p"/path") uses the endpoint URL from config (host, scheme, port)
# - url(%URI{}, ~p"/path") substitutes a custom host at runtime
# - path vs url: the sigil is a path; url/1 prepends the endpoint
# - put_router_url/2 on a conn is the override the island-host action uses

defmodule PhoenixMultivitaminWeb.MataveriMetarDrumLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.MataveriMetarDrumController

  @island_uri %URI{scheme: "https", host: "metar.mataveri.cl", port: 443}

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Mataveri METAR drum")
     |> assign(:station, "Mataveri METAR drum")
     |> assign(:observer, "Hina")
     |> assign(:drum_path, drum_path())
     |> assign(:endpoint_url, url(~p"/features/02-verified-routes/08-mataveri-metar-drum"))
     |> assign(
       :island_url,
       url(@island_uri, ~p"/features/02-verified-routes/08-mataveri-metar-drum")
     )
     |> assign(:island_host_path, MataveriMetarDrumController.island_host_path())}
  end

  def drum_path, do: ~p"/features/02-verified-routes/08-mataveri-metar-drum"

  def island_uri, do: @island_uri

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 08 · Mataveri METAR drum
      </p>

      <h1>Mataveri METAR drum</h1>
      <p class="lede">
        Observer {@observer} winds the METAR drum at {@station} on Rapa Nui
        for the Boeing 787-9. ~p is a path. url/1 hangs the endpoint host on it.
        A URI hangs the island's own host instead.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Observer</dt>
        <dd id="observer-name">{@observer}</dd>
        <dt>Path</dt>
        <dd id="drum-path">{@drum_path}</dd>
        <dt>Endpoint URL</dt>
        <dd id="endpoint-url">{@endpoint_url}</dd>
        <dt>Island URL</dt>
        <dd id="island-url">{@island_url}</dd>
        <dt>Island-host action</dt>
        <dd id="island-host-path">{@island_host_path}</dd>
      </dl>

      <div class="watch-actions">
        <.link id="fetch-island-host" href={@island_host_path}>Fetch island host URL</.link>
      </div>

      <div class="scenario">
        <h2>Drum</h2>
        <p id="drum-copy">
          METAR drum posting for Mataveri. Path {@drum_path}. Public URL {@island_url}.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
