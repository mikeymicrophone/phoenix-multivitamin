# Routing and plugs · 12 · Rosario watch floor
#
# Teaches:
# - Nested scopes concatenate prefixes and accumulate pipe_through
# - A sibling scope starts a new stack

defmodule PhoenixMultivitaminWeb.RosarioWatchFloorLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Rosario watch floor")
     |> assign(:strait, "Rosario Strait")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 12 · Rosario watch floor
      </p>

      <h1>Rosario watch floor</h1>
      <p class="lede">
        Watches along {@strait} nest station inside the strait and watch
        inside the station. The relief boat is a sibling scope: it gets the
        watch plug without the strait plug.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-lime-kiln"
          href={
            ~p"/features/01-routing-and-plugs/12-rosario-watch-floor/station/lime-kiln/watch/evening/floor"
          }
        >
          Lime Kiln evening
        </.link>
        <.link
          id="open-relief"
          href={~p"/features/01-routing-and-plugs/12-rosario-watch-floor/relief/floor"}
        >
          Relief boat
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
