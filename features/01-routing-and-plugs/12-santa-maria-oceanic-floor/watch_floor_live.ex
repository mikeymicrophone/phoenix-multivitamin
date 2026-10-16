# Routing and plugs · 12 · Santa Maria oceanic floor
#
# Teaches:
# - Nested scopes concatenate prefixes and accumulate pipe_through
# - A sibling scope starts a new stack

defmodule PhoenixMultivitaminWeb.SantaMariaOceanicFloorLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Santa Maria oceanic floor")
     |> assign(:fir, "Santa Maria Oceanic")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 12 · Santa Maria oceanic floor
      </p>

      <h1>Santa Maria oceanic floor</h1>
      <p class="lede">
        Watches along {@fir} nest station inside the FIR and watch
        inside the station. The relief radio is a sibling scope: it gets the
        watch plug without the oceanic plug.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-santa-maria"
          href={
            ~p"/features/01-routing-and-plugs/12-santa-maria-oceanic-floor/station/santa-maria/watch/evening/floor"
          }
        >
          Santa Maria evening
        </.link>
        <.link
          id="open-relief"
          href={~p"/features/01-routing-and-plugs/12-santa-maria-oceanic-floor/relief/floor"}
        >
          Relief radio
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
