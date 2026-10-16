# Routing and plugs · 03 · Incheon bonded shed
#
# Teaches:
# - Sibling scopes share a controller and split the inspector plug by lane
# - resources/4 under each prefix draws index and show

defmodule PhoenixMultivitaminWeb.IncheonBondedShedLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Incheon bonded shed")
     |> assign(:inspector, "Haneul")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 03 · Incheon bonded shed
      </p>

      <h1>Incheon bonded shed</h1>
      <p class="lede">
        Inspector {@inspector} keeps two ledgers in one shed: arrivals off
        Narita and departures toward Xi'an. Each lane is a scope with
        the same resources.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-arrivals"
          href={~p"/features/01-routing-and-plugs/03-incheon-bonded-shed/arrivals/declarations"}
        >
          Arrivals ledger
        </.link>
        <.link
          id="open-departures"
          href={~p"/features/01-routing-and-plugs/03-incheon-bonded-shed/departures/declarations"}
        >
          Departures ledger
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
