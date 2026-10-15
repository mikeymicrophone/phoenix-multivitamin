defmodule PhoenixMultivitaminWeb.RosarioWatchFloorHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 12 · Rosario watch floor
      </p>

      <h1>Rosario watch floor</h1>
      <p class="lede">
        Keeper {@keeper} stands the {@watch} watch at {@station} on {@strait}. Nested scopes stacked the path. Nested pipe_through stacked
        the plugs.
      </p>

      <dl class="station-meta">
        <dt>Board</dt>
        <dd id="board-kind">{@board}</dd>
        <dt>Strait</dt>
        <dd id="strait-name">{@strait}</dd>
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Watch</dt>
        <dd id="watch-name">{@watch}</dd>
        <dt>Station is a string</dt>
        <dd id="station-binary">{if @station_is_binary, do: "yes", else: "no"}</dd>
        <dt>Watch is a string</dt>
        <dd id="watch-binary">{if @watch_is_binary, do: "yes", else: "no"}</dd>
      </dl>

      <div class="scenario">
        <h2>Plug order</h2>
        <ol id="pipeline-trace">
          <li :for={step <- @pipeline_trace} id={"trace-#{step}"}>{step}</li>
        </ol>
      </div>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/12-rosario-watch-floor"}>
          Strait map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
