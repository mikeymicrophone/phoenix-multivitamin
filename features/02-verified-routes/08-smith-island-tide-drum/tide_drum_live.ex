# Verified routes · 08 · Smith Island tide drum
#
# Teaches:
# - url(~p"/path") uses the endpoint URL from config (host, scheme, port)
# - url(%URI{}, ~p"/path") substitutes a custom host at runtime
# - path vs url: the sigil is a path; url/1 prepends the endpoint
# - put_router_url/2 on a conn is the override the island-host action uses

defmodule PhoenixMultivitaminWeb.SmithIslandTideDrumLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.SmithIslandTideDrumController

  @island_uri %URI{scheme: "https", host: "tidedrum.smithisland.wa.gov", port: 443}

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Smith Island tide drum")
     |> assign(:station, "Smith Island Light")
     |> assign(:keeper, "Calder")
     |> assign(:drum_path, drum_path())
     |> assign(:endpoint_url, url(~p"/features/02-verified-routes/08-smith-island-tide-drum"))
     |> assign(
       :island_url,
       url(@island_uri, ~p"/features/02-verified-routes/08-smith-island-tide-drum")
     )
     |> assign(:island_host_path, SmithIslandTideDrumController.island_host_path())}
  end

  def drum_path, do: ~p"/features/02-verified-routes/08-smith-island-tide-drum"

  def island_uri, do: @island_uri

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 08 · Smith Island tide drum
      </p>

      <h1>Smith Island tide drum</h1>
      <p class="lede">
        Keeper {@keeper} winds the tide drum at {@station} in the Strait of
        Juan de Fuca. ~p is a path. url/1 hangs the endpoint host on it.
        A URI hangs the island's own host instead.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
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
          Tide drum posting for Smith Island. Path {@drum_path}. Public URL {@island_url}.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
