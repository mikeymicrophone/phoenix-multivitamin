# Controllers and JSON · 06 · Dakar harmattan METAR
#
# Teaches:
# - Accept headers pick html versus json on one path

defmodule PhoenixMultivitaminWeb.DakarHarmattanMetarLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Dakar harmattan METAR")
     |> assign(:station, "Dakar Blaise Diagne")
     |> assign(:person, "Awa")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 06 · Dakar harmattan METAR
      </p>

      <h1>Dakar harmattan METAR</h1>
      <p class="lede">
        Observer {@person} posts the harmattan METAR at {@station} for a Boeing 777-200ER.
        One path, two Accept headers. <code>get_format/1</code> picks the body.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-metar"
          href={~p"/features/03-controllers-and-json/06-dakar-harmattan-metar/metar"}
        >
          Open the harmattan METAR
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
