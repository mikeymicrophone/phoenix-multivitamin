# Controllers and JSON · 03 · Marrakech ATIS feed
#
# Teaches:
# - The catalog page is a LiveView; posting an ATIS hits a controller
# - Invalid posts return {:error, changeset} for the fallback

defmodule PhoenixMultivitaminWeb.MarrakechAtisFeedLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Marrakech ATIS feed")
     |> assign(:station, "Marrakech Menara")
     |> assign(:person, "Youssef")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 03 · Marrakech ATIS feed
      </p>

      <h1>Marrakech ATIS feed</h1>
      <p class="lede">
        {@person} posts information Bravo at {@station}. A valid post is 201 JSON.
        A short info line is an error changeset the fallback controller paints.
      </p>

      <div class="watch-switcher">
        <.link id="open-atis" href={~p"/features/03-controllers-and-json/03-marrakech-atis-feed/atis"}>
          Open the ATIS board
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
