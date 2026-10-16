# LiveComponents · 07 · Samos stateless plate
#
# Teaches:
# - A stateless component still requires an id in LiveView 1.2

defmodule PhoenixMultivitaminWeb.SamosStatelessPlateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.SamosStatelessPlate

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Samos stateless plate")
     |> assign(:clerk, "Eleni")
     |> assign(:craft, "Socata TBM 900")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 07 · Samos stateless plate
      </p>

      <h1>Samos stateless plate</h1>
      <p class="lede">
        Clerk {@clerk} stamps a {@craft} plate that only renders. LiveView
        still requires an id.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.live_component
        module={SamosStatelessPlate}
        id="samos-plate"
        clerk={@clerk}
        craft={@craft}
        qnh="1016"
      />
    </Layouts.catalog>
    """
  end
end
