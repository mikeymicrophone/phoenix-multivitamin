# LiveView navigation · 02 · Rovaniemi aurora cabin
#
# Teaches:
# - This module is a different LiveView from the desk
# - navigate/2 mounts it fresh

defmodule PhoenixMultivitaminWeb.RovaniemiAuroraCabinLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Rovaniemi aurora desk")
     |> assign(:clerk, "Aino")
     |> assign(:craft, "ATR 72")
     |> assign(:clicks, 0)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 02 · Rovaniemi aurora desk
      </p>

      <h1>Rovaniemi aurora desk</h1>
      <p class="lede">
        Clerk {@clerk} is in the {@craft} cabin. This is a new LiveView process.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="cabin-clicks">{@clicks}</p>
      <p id="surface-name">cabin</p>
    </Layouts.catalog>
    """
  end
end
