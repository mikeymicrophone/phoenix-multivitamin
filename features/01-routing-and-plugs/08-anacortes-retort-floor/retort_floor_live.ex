# Routing and plugs · 08 · Anacortes retort floor
#
# Teaches:
# - Browser and API pipelines can share one controller
# - accepts/2 406s a mismatched Accept header

defmodule PhoenixMultivitaminWeb.AnacortesRetortFloorLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Anacortes retort floor")
     |> assign(:cannery, "Pacific American Cannery")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 08 · Anacortes retort floor
      </p>

      <h1>Anacortes retort floor</h1>
      <p class="lede">
        {@cannery} still posts cook cards on the floor and as JSON for the
        lab. Same controller, two pipelines.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-floor"
          href={~p"/features/01-routing-and-plugs/08-anacortes-retort-floor/floor/cooks"}
        >
          Floor ledger
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
