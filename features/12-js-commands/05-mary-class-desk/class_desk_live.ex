# JS commands · 05 · Mary class desk
#
# Teaches:
# - JS.add_class/1 and JS.remove_class/1

defmodule PhoenixMultivitaminWeb.MaryClassDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Mary class desk", "Maral", "Boeing 757-200")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 05 · Mary class desk
      </p>

      <h1>Mary class desk</h1>
      <p class="lede">
        Clerk {@clerk} paints and clears a heat class on the {@craft} vane.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button
        id="add-heat"
        type="button"
        phx-click={JS.add_class("hot-vane", to: "#merv-vane")}
      >
        Add heat
      </button>
      <button
        id="clear-heat"
        type="button"
        phx-click={JS.remove_class("hot-vane", to: "#merv-vane")}
      >
        Clear heat
      </button>

      <p id="merv-vane">Merv vane.</p>
    </Layouts.app>
    """
  end
end
