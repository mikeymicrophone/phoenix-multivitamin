# Verified routes · 03 · Patos Island fog logger
#
# Teaches:
# - Dynamic segments interpolate through Phoenix.Param, not inspect/1
# - @derive {Phoenix.Param, key: :slug} lets ~p"/watches/#{watch}" use the slug
# - A map is not a struct; interpolating a map raises ArgumentError
# - A list of binaries becomes extra path segments at runtime, still verified as one

defmodule PhoenixMultivitaminWeb.PatosIslandFogLoggerLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.PatosIslandWatch

  @watches %{
    "dawn" => %PatosIslandWatch{
      slug: "dawn",
      keeper: "Orrin",
      window: "04:00–08:00",
      horn: "two-blast"
    },
    "dusk" => %PatosIslandWatch{
      slug: "dusk",
      keeper: "Tamsin",
      window: "16:00–20:00",
      horn: "one-blast"
    }
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Patos Island fog logger")
     |> assign(:station, "Patos Island Light")
     |> assign(:watches, [@watches["dawn"], @watches["dusk"]])}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    watch = Map.get(@watches, Map.get(params, "watch", "dawn"), @watches["dawn"])

    {:noreply,
     socket
     |> assign(:watch, watch)
     |> assign(:dawn_path, watch_path(@watches["dawn"]))
     |> assign(:dusk_path, watch_path(@watches["dusk"]))
     |> assign(:encoded_path, watch_path("west bank"))}
  end

  def logger_path, do: ~p"/features/02-verified-routes/03-patos-island-fog-logger"

  def watch_path(%PatosIslandWatch{} = watch) do
    ~p"/features/02-verified-routes/03-patos-island-fog-logger/watches/#{watch}"
  end

  def watch_path(slug) when is_binary(slug) do
    ~p"/features/02-verified-routes/03-patos-island-fog-logger/watches/#{slug}"
  end

  def watch_path(slugs) when is_list(slugs) do
    ~p"/features/02-verified-routes/03-patos-island-fog-logger/watches/#{slugs}"
  end

  def watch_path(other) do
    ~p"/features/02-verified-routes/03-patos-island-fog-logger/watches/#{other}"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 03 · Patos Island fog logger
      </p>

      <h1>Patos Island fog logger</h1>
      <p class="lede">
        {@watch.keeper} logs fog on {@station}, the northern light of the
        San Juans. Each watch card interpolates through Phoenix.Param into a
        verified path.
      </p>

      <div class="watch-switcher">
        <.link id="dawn-watch-link" navigate={@dawn_path}>Dawn watch</.link>
        <.link id="dusk-watch-link" navigate={@dusk_path}>Dusk watch</.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@watch.keeper}</dd>
        <dt>Watch</dt>
        <dd id="watch-name">{@watch.slug} ({@watch.window})</dd>
        <dt>Horn</dt>
        <dd id="watch-horn">{@watch.horn}</dd>
        <dt>Dawn path</dt>
        <dd id="dawn-watch-path">{@dawn_path}</dd>
        <dt>Dusk path</dt>
        <dd id="dusk-watch-path">{@dusk_path}</dd>
        <dt>Encoded bank</dt>
        <dd id="encoded-watch-path">{@encoded_path}</dd>
      </dl>

      <div class="scenario">
        <h2>Fog log</h2>
        <p id="fog-copy">
          {@watch.keeper} on {@watch.slug} watch, {@watch.horn} at the
          five-minute mark.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
