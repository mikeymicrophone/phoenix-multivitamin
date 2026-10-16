# Controllers and JSON · 10 · Leh density-altitude card
#
# Teaches:
# - Params arrive nested under a domain key

defmodule PhoenixMultivitaminWeb.LehDensityAltitudeCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Leh density-altitude card")
     |> assign(:station, "Kushok Bakula Rimpochee")
     |> assign(:person, "Tenzin")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Controllers and JSON · 10 · Leh density-altitude card
      </p>

      <h1>Leh density-altitude card</h1>
      <p class="lede">
        Engineer {@person} computes takeoff for an Antonov An-32 at {@station}.
        The post is nested under <code>card</code>. The action pattern-matches that key.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-card"
          href={~p"/features/03-controllers-and-json/10-leh-density-altitude-card/card"}
        >
          Open the density-altitude card
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
