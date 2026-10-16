# Routing and plugs · 02 · Tromsø SAR hoist
#
# Teaches:
# - A module plug can halt a request that is missing a winch ticket
# - The dispatcher action never runs when the plug has halted

defmodule PhoenixMultivitaminWeb.TromsoSarHoistLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Tromsø SAR hoist")
     |> assign(:pad, "Tromsø SAR pad")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 02 · Tromsø SAR hoist
      </p>

      <h1>Tromsø SAR hoist</h1>
      <p class="lede">
        The Westland Sea King at {@pad} will not winch without ticket hoist-17 on the
        request. Send that header and winch operator Sigrid slots the Sea King.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-pad"
          href={~p"/features/01-routing-and-plugs/02-tromso-sar-hoist/pad"}
        >
          Walk onto the pad
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
