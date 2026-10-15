# Routing and plugs · 01 · Admiralty Inlet tide gate
#
# Teaches:
# - The catalog page is a LiveView; the tide board is a controller behind a pipeline
# - Open the inlet path to see plugs stamp the conn before show/2

defmodule PhoenixMultivitaminWeb.AdmiraltyInletTideGateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Admiralty Inlet tide gate")
     |> assign(:station, "Point Wilson Light")
     |> assign(:keeper, "Maren")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 01 · Admiralty Inlet tide gate
      </p>

      <h1>Admiralty Inlet tide gate</h1>
      <p class="lede">
        {@keeper} keeps the paper map at {@station}. The working gate is a
        controller sitting behind a router pipeline and two function plugs.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-inlet"
          href={~p"/features/01-routing-and-plugs/01-admiralty-inlet-tide-gate/inlet"}
        >
          Open the tide gate
        </.link>
      </div>

      <div class="scenario">
        <h2>What the inlet will stamp</h2>
        <p>
          The pipeline plug names Admiralty Inlet. The controller then stamps
          the flood window through Partridge Bank and the HTTP method. The
          board lists those steps in order.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
