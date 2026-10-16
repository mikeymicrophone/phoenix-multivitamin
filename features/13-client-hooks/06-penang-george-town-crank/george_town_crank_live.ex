# Client hooks · 06 · Penang George Town crank
#
# Teaches:
# - pushEventTo targets a LiveComponent root by selector and replies to that hook alone.
# - Map.fetch/2 and cond distinguish an unknown direction, a ratchet stop, and an accepted turn.

defmodule PhoenixMultivitaminWeb.PenangGeorgeTownCrankLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.PenangTowbarCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Penang George Town crank", "Faridah", "Boeing 737-800")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 06 · Penang George Town crank
      </p>

      <h1>Penang George Town crank</h1>
      <p class="lede">
        Ground chief {@clerk} checks two towbar cranks for the {@craft}; each tug keeps its own
        ratchet position.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div class="mt-6 grid gap-4 sm:grid-cols-2">
        <.live_component module={PenangTowbarCell} id="north-tug" tug="North tug" />
        <.live_component module={PenangTowbarCell} id="south-tug" tug="South tug" />
      </div>
    </Layouts.app>
    """
  end
end
