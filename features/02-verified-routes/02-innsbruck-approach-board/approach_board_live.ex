# Verified routes · 02 · Innsbruck approach board
#
# Teaches:
# - Query strings belong in the ~p sigil, not concatenated after a path
# - A keyword list or a map both encode; values are URL-encoded
# - An empty query omits the ?; sort_verified_routes_query_params orders keys
# - handle_params/3 reads the verified query the same as any other URL

defmodule PhoenixMultivitaminWeb.InnsbruckApproachBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Innsbruck approach board")
     |> assign(:station, "Innsbruck approach")
     |> assign(:atco, "Lena")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    loc = Map.get(params, "loc", "inner")
    radial = Map.get(params, "radial", "256")

    {:noreply,
     socket
     |> assign(:loc, loc)
     |> assign(:radial, radial)
     |> assign(:inner_path, inner_approach_path())
     |> assign(:outer_path, outer_approach_path())
     |> assign(:keyword_path, approach_query_path(loc: "outer", radial: "256"))
     |> assign(:map_path, approach_query_path(%{"radial" => "256", "loc" => "outer"}))
     |> assign(:spaced_path, approach_query_path(loc: "inner", note: "inn valley"))}
  end

  @impl true
  def handle_event("show_inner", _params, socket) do
    {:noreply, push_patch(socket, to: inner_approach_path())}
  end

  def handle_event("show_outer", _params, socket) do
    {:noreply, push_patch(socket, to: outer_approach_path())}
  end

  def board_path, do: ~p"/features/02-verified-routes/02-innsbruck-approach-board"

  def inner_approach_path, do: approach_query_path(loc: "inner", radial: "256")

  def outer_approach_path, do: approach_query_path(loc: "outer", radial: "256")

  def approach_query_path(query) when is_list(query) or is_map(query) do
    ~p"/features/02-verified-routes/02-innsbruck-approach-board?#{query}"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 02 · Innsbruck approach board
      </p>

      <h1>Innsbruck approach board</h1>
      <p class="lede">
        ATCO {@atco} lines up the Embraer 195 on the {@station}. Query strings ride inside ~p,
        never concatenated onto the path.
      </p>

      <div class="watch-switcher">
        <.link id="inner-approach-link" patch={@inner_path}>Inner marker</.link>
        <.link id="outer-approach-link" patch={@outer_path}>Outer marker</.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>ATCO</dt>
        <dd id="atco-name">{@atco}</dd>
        <dt>Localizer</dt>
        <dd id="approach-loc">{@loc}</dd>
        <dt>Radial</dt>
        <dd id="approach-radial">{@radial}° inbound</dd>
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
        <button id="show-inner" type="button" phx-click="show_inner">Show inner</button>
        <button id="show-outer" type="button" phx-click="show_outer">Show outer</button>
      </div>

      <div class="scenario">
        <h2>Approach</h2>
        <p id="approach-copy">
          {@loc} marker, radial {@radial}° inbound, lined up for Innsbruck.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
