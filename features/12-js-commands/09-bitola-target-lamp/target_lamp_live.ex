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
     |> assign(:page_title, "Bitola target lamp")
     |> assign(:clerk, "Iskra")
     |> assign(:craft, "Piper PA-31 Navajo")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 09 · Bitola target lamp
      </p>

      <h1>Bitola target lamp</h1>
      <p class="lede">
        Clerk {@clerk} clicks a switch that lights a different {@craft} lamp.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button
        id="light-other"
        type="button"
        phx-click={JS.add_class("lit", to: "#pelister-lamp")}
      >
        Light Pelister
      </button>

      <p id="pelister-lamp">Pelister lamp.</p>
    </Layouts.catalog>
    """
  end
end
