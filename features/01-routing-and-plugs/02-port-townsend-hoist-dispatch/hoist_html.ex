defmodule PhoenixMultivitaminWeb.PortTownsendHoistDispatchHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def dispatch(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Routing and plugs · 02 · Port Townsend hoist dispatch
      </p>

      <h1>Port Townsend hoist dispatch</h1>
      <p class="lede">
        Dispatcher {@dispatcher} slots {@hull} into {@hoist} at {@yard}. The
        pipeline plug already checked the boat-yard ticket.
      </p>

      <p id="dispatch-banner" class="mount-banner">
        Ticket hoist-17 accepted. The Travelift may lift.
      </p>

      <dl class="station-meta">
        <dt>Yard</dt>
        <dd id="yard-name">{@yard}</dd>
        <dt>Hoist</dt>
        <dd id="hoist-name">{@hoist}</dd>
        <dt>Dispatcher</dt>
        <dd id="dispatcher-name">{@dispatcher}</dd>
        <dt>Hull</dt>
        <dd id="hull-name">{@hull}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/02-port-townsend-hoist-dispatch"}>
          Yard map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end

  def locked(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Routing and plugs · 02 · Port Townsend hoist dispatch
      </p>

      <h1>Port Townsend hoist dispatch</h1>
      <p id="locked-banner" class="mount-banner static-mount">
        Hoist ticket missing. The Travelift stays locked. Dispatcher Hollis
        never sees this request.
      </p>

      <dl class="station-meta">
        <dt>Yard</dt>
        <dd id="yard-name">{@yard}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/02-port-townsend-hoist-dispatch"}>
          Yard map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
