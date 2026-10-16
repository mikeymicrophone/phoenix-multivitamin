# Routing and plugs · 11 · Bergen briefing desk
#
# Teaches:
# - A session plug redirects missing dispatchers to the roster
# - redirect/2 without halt/1 still runs the desk action

defmodule PhoenixMultivitaminWeb.BergenBriefingDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Bergen briefing desk")
     |> assign(:station, "Bergen Flesland")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 11 · Bergen briefing desk
      </p>

      <h1>Bergen briefing desk</h1>
      <p class="lede">
        {@station} keeps the SID plates in a drawer. A plug reads the
        session for dispatcher Åse. Redirect without halt still opens the drawer.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-roster"
          href={~p"/features/01-routing-and-plugs/11-bergen-briefing-desk/roster"}
        >
          Roster
        </.link>
        <.link id="open-desk" href={~p"/features/01-routing-and-plugs/11-bergen-briefing-desk/desk"}>
          Briefing desk
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
