# Verified routes · 02 · Bush Point range board
#
# Teaches:
# - Query strings belong in the ~p sigil, not concatenated after a path
# - A keyword list or a map both encode; values are URL-encoded
# - An empty query omits the ?; sort_verified_routes_query_params orders keys
# - handle_params/3 reads the verified query the same as any other URL

defmodule PhoenixMultivitaminWeb.BushPointRangeBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Bush Point range board")
     |> assign(:station, "Bush Point Range")
     |> assign(:keeper, "Ned")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    light = Map.get(params, "light", "front")
    bearing = Map.get(params, "bearing", "187")

    {:noreply,
     socket
     |> assign(:light, light)
     |> assign(:bearing, bearing)
     |> assign(:front_path, front_range_path())
     |> assign(:rear_path, rear_range_path())
     |> assign(:keyword_path, range_query_path(light: "rear", bearing: "187"))
     |> assign(:map_path, range_query_path(%{"bearing" => "187", "light" => "rear"}))
     |> assign(:spaced_path, range_query_path(light: "front", note: "west bank"))}
  end

  @impl true
  def handle_event("show_front", _params, socket) do
    {:noreply, push_patch(socket, to: front_range_path())}
  end

  def handle_event("show_rear", _params, socket) do
    {:noreply, push_patch(socket, to: rear_range_path())}
  end

  def board_path, do: ~p"/features/02-verified-routes/02-bush-point-range-board"

  def front_range_path, do: range_query_path(light: "front", bearing: "187")

  def rear_range_path, do: range_query_path(light: "rear", bearing: "187")

  def range_query_path(query) when is_list(query) or is_map(query) do
    ~p"/features/02-verified-routes/02-bush-point-range-board?#{query}"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 02 · Bush Point range board
      </p>

      <h1>Bush Point range board</h1>
      <p class="lede">
        Keeper {@keeper} lines up the {@station} lights for Admiralty Inlet. Query strings ride inside ~p,
        never concatenated onto the path.
      </p>

      <div class="watch-switcher">
        <.link id="front-range-link" patch={@front_path}>Front range</.link>
        <.link id="rear-range-link" patch={@rear_path}>Rear range</.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Light</dt>
        <dd id="range-light">{@light}</dd>
        <dt>Bearing</dt>
        <dd id="range-bearing">{@bearing}° true</dd>
        <dt>Keyword query</dt>
        <dd id="keyword-query-path">{@keyword_path}</dd>
        <dt>Map query</dt>
        <dd id="map-query-path">{@map_path}</dd>
        <dt>Encoded note</dt>
        <dd id="spaced-query-path">{@spaced_path}</dd>
        <dt>Bare board</dt>
        <dd id="bare-board-path">{board_path()}</dd>
      </dl>

      <div class="watch-actions">
        <button id="show-front" type="button" phx-click="show_front">Show front</button>
        <button id="show-rear" type="button" phx-click="show_rear">Show rear</button>
      </div>

      <div class="scenario">
        <h2>Range</h2>
        <p id="range-copy">
          {@light} light, bearing {@bearing}° true, lined up off Bush Point.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
