# Async assigns · 11 · Norilsk hoist exit
#
# Teaches:
# - An async function that exits fails the assign
# - The failed reason is {:exit, :hoist_cable_snap}

defmodule PhoenixMultivitaminWeb.NorilskHoistExitLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Norilsk hoist exit")
     |> assign(:clerk, "Gavril")
     |> assign(:craft, "Mil Mi-26")
     |> assign_async(:hoist, fn ->
       Process.exit(self(), :hoist_cable_snap)
     end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 11 · Norilsk hoist exit
      </p>

      <h1>Norilsk hoist exit</h1>
      <p class="lede">
        Clerk {@clerk} starts a hoist on the {@craft}. The async process
        exits. The LiveView stays up and paints the reason.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={@hoist.loading} id="hoist-loading">Hoist still on the cable.</p>
      <p :if={@hoist.failed} id="hoist-failed">{inspect(@hoist.failed)}</p>
    </Layouts.catalog>
    """
  end
end
