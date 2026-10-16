# Routing and plugs · 01 · Lukla shear gate
#
# Teaches:
# - The catalog page is a LiveView; the inbound board is a controller behind a pipeline
# - Open the approach path to see plugs stamp the conn before show/2

defmodule PhoenixMultivitaminWeb.LuklaShearGateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Lukla shear gate")
     |> assign(:station, "Tenzing–Hillary")
     |> assign(:controller_name, "Tashi")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 01 · Lukla shear gate
      </p>

      <h1>Lukla shear gate</h1>
      <p class="lede">
        {@controller_name} keeps the paper map at {@station}. The working gate is a
        controller sitting behind a router pipeline and two function plugs.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-approach"
          href={~p"/features/01-routing-and-plugs/01-lukla-shear-gate/approach"}
        >
          Open the shear gate
        </.link>
      </div>

      <div class="scenario">
        <h2>What the approach will stamp</h2>
        <p>
          The pipeline plug names the Khumbu approach. The controller then stamps
          the westerly rotor off Nupla and the HTTP method. The
          board lists those steps in order.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
