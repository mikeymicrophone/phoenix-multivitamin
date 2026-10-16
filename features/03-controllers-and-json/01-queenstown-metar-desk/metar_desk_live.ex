# Controllers and JSON · 01 · Queenstown METAR desk
#
# Teaches:
# - The catalog page is a LiveView; the working desk is a controller (or layout demo)

defmodule PhoenixMultivitaminWeb.QueenstownMetarDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Queenstown METAR desk")
     |> assign(:station, "Queenstown Airport")
     |> assign(:person, "Kahu")
     |> assign(:craft, "King Air 200")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 01 · Queenstown METAR desk
      </p>

      <h1>Queenstown METAR desk</h1>
      <p class="lede">
        {@person} at {@station}. The paper card is this LiveView. The working METAR is one controller that draws HTML and exports JSON.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-metar"
          href={~p"/features/03-controllers-and-json/01-queenstown-metar-desk/metar"}
        >
          Open the METAR board
        </.link>
        <.link
          id="export-metar"
          href={~p"/features/03-controllers-and-json/01-queenstown-metar-desk/metar/export"}
        >
          Export JSON
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
