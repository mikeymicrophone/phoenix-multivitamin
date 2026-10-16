# Async assigns · 11 · Norilsk hoist exit
#
# Teaches:
# - Process.exit/2 inside assign_async is linked to the LiveView
# - The LiveView exits with :hoist_cable_snap; it is not a failed assign

defmodule PhoenixMultivitaminWeb.NorilskHoistExitLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Norilsk hoist exit", "Gavril", "Mil Mi-26")
     |> assign_async(:hoist, fn ->
       Process.exit(self(), :hoist_cable_snap)
     end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 11 · Norilsk hoist exit
      </p>

      <h1>Norilsk hoist exit</h1>
      <p class="lede">
        Clerk {@clerk} starts a hoist on the {@craft}. The async process
        exits. Because it is linked, this LiveView exits too.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p :if={@hoist.loading} id="hoist-loading">Hoist still on the cable.</p>
      <p :if={@hoist.failed} id="hoist-failed">{inspect(@hoist.failed)}</p>
    </Layouts.app>
    """
  end
end
