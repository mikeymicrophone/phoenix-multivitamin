# Routing and plugs · 02 · Port Townsend hoist dispatch
#
# Teaches:
# - A module plug can halt a request that is missing a boat-yard ticket
# - The dispatcher action never runs when the plug has halted

defmodule PhoenixMultivitaminWeb.PortTownsendHoistDispatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Port Townsend hoist dispatch")
     |> assign(:yard, "Port Townsend Shipwrights Co-op")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Routing and plugs · 02 · Port Townsend hoist dispatch
      </p>

      <h1>Port Townsend hoist dispatch</h1>
      <p class="lede">
        The Travelift at {@yard} will not move without ticket hoist-17 on the
        request. Send that header and dispatcher Hollis slots troller Marigold.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-yard"
          href={~p"/features/01-routing-and-plugs/02-port-townsend-hoist-dispatch/yard"}
        >
          Walk into the yard
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
