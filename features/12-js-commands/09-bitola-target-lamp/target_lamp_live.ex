# JS commands · 09 · Bitola target lamp
#
# Teaches:
# - to: targeting a different element

defmodule PhoenixMultivitaminWeb.BitolaTargetLampLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Bitola target lamp", "Iskra", "Piper PA-31 Navajo")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 09 · Bitola target lamp
      </p>

      <h1>Bitola target lamp</h1>
      <p class="lede">
        Clerk {@clerk} clicks a switch that lights a different {@craft} lamp.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button
        id="light-other"
        type="button"
        phx-click={JS.add_class("lit", to: "#pelister-lamp")}
      >
        Light Pelister
      </button>

      <p id="pelister-lamp">Pelister lamp.</p>
    </Layouts.app>
    """
  end
end
