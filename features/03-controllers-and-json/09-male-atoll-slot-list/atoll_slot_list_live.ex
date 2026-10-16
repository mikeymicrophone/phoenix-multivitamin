# Controllers and JSON · 09 · Malé atoll slot list
#
# Teaches:
# - A missing slot is a JSON error map, not the HTML ErrorHTML page

defmodule PhoenixMultivitaminWeb.MaleAtollSlotListLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Malé atoll slot list")
     |> assign(:station, "Velana")
     |> assign(:person, "Mariyam")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 09 · Malé atoll slot list
      </p>

      <h1>Malé atoll slot list</h1>
      <p class="lede">
        Clerk {@person} looks up Airbus A321 water slots at {@station}.
        A known slot is JSON. A missing one is a 404 error map, not an HTML page.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-hulhule-slot"
          href={~p"/features/03-controllers-and-json/09-male-atoll-slot-list/slots/hulhule-14"}
        >
          Open Hulhulé 14
        </.link>
        <.link
          id="open-missing-slot"
          href={~p"/features/03-controllers-and-json/09-male-atoll-slot-list/slots/missing"}
        >
          Ask for a missing slot
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
