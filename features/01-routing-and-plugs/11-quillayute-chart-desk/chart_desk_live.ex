# Routing and plugs · 11 · Quillayute chart desk
#
# Teaches:
# - A session plug redirects missing officers to the roster
# - redirect/2 without halt/1 still runs the desk action

defmodule PhoenixMultivitaminWeb.QuillayuteChartDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Quillayute chart desk")
     |> assign(:station, "Quillayute River Coast Guard Station")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 11 · Quillayute chart desk
      </p>

      <h1>Quillayute chart desk</h1>
      <p class="lede">
        {@station} keeps the La Push bar charts in a drawer. A plug reads the
        session for officer Wren. Redirect without halt still opens the drawer.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-roster"
          href={~p"/features/01-routing-and-plugs/11-quillayute-chart-desk/roster"}
        >
          Roster
        </.link>
        <.link id="open-desk" href={~p"/features/01-routing-and-plugs/11-quillayute-chart-desk/desk"}>
          Chart desk
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
