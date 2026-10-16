defmodule PhoenixMultivitaminWeb.TromsoSarHoistHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def dispatch(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 02 · Tromsø SAR hoist
      </p>

      <h1>Tromsø SAR hoist</h1>
      <p class="lede">
        Winch operator {@winch_operator} slots {@craft} into {@hoist} at {@pad}. The
        pipeline plug already checked the winch ticket.
      </p>

      <p id="dispatch-banner" class="mount-banner">
        Ticket hoist-17 accepted. The Sea King may hoist.
      </p>

      <dl class="station-meta">
        <dt>Pad</dt>
        <dd id="pad-name">{@pad}</dd>
        <dt>Hoist</dt>
        <dd id="hoist-name">{@hoist}</dd>
        <dt>Winch operator</dt>
        <dd id="winch-operator-name">{@winch_operator}</dd>
        <dt>Craft</dt>
        <dd id="craft-name">{@craft}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/02-tromso-sar-hoist"}>
          Pad map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end

  def locked(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 02 · Tromsø SAR hoist
      </p>

      <h1>Tromsø SAR hoist</h1>
      <p id="locked-banner" class="mount-banner static-mount">
        Hoist ticket missing. The Sea King winch stays locked. Winch operator Sigrid
        never sees this request.
      </p>

      <dl class="station-meta">
        <dt>Pad</dt>
        <dd id="pad-name">{@pad}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/02-tromso-sar-hoist"}>
          Pad map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
