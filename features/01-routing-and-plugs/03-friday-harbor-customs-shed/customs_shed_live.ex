# Routing and plugs · 03 · Friday Harbor customs shed
#
# Teaches:
# - Sibling scopes share a controller and split the inspector plug by lane
# - resources/4 under each prefix draws index and show

defmodule PhoenixMultivitaminWeb.FridayHarborCustomsShedLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Friday Harbor customs shed")
     |> assign(:inspector, "Ellis")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 03 · Friday Harbor customs shed
      </p>

      <h1>Friday Harbor customs shed</h1>
      <p class="lede">
        Inspector {@inspector} keeps two ledgers in one shed: arrivals off
        Victoria and departures toward Lime Kiln. Each lane is a scope with
        the same resources.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-arrivals"
          href={
            ~p"/features/01-routing-and-plugs/03-friday-harbor-customs-shed/arrivals/declarations"
          }
        >
          Arrivals ledger
        </.link>
        <.link
          id="open-departures"
          href={
            ~p"/features/01-routing-and-plugs/03-friday-harbor-customs-shed/departures/declarations"
          }
        >
          Departures ledger
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
