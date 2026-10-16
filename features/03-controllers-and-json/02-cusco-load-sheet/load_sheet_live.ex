# Controllers and JSON · 02 · Cusco load sheet
#
# Teaches:
# - The catalog page is a LiveView; the working desk is a controller (or layout demo)

defmodule PhoenixMultivitaminWeb.CuscoLoadSheetLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Cusco load sheet")
     |> assign(:station, "Alejandro Velasco Astete")
     |> assign(:person, "Inti")
     |> assign(:craft, "Boeing 737-700")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 02 · Cusco load sheet
      </p>

      <h1>Cusco load sheet</h1>
      <p class="lede">
        {@person} at {@station}. The accepted load sheet is `put_status/2` then `json/2` — created, not just 200.
      </p>

      <div class="watch-switcher">
        <.link id="open-sheet" href={~p"/features/03-controllers-and-json/02-cusco-load-sheet/sheet"}>
          Accept the load sheet
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
