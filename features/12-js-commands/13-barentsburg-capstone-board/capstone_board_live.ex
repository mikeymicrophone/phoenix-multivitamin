# JS commands · 13 · Barentsburg capstone board
#
# Teaches:
# - Toggle, push, and a transition on one board

defmodule PhoenixMultivitaminWeb.BarentsburgCapstoneBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Barentsburg capstone board", "Lars", "Eurocopter AS332 Super Puma")
     |> assign(:logged, "quiet")}
  end

  @impl true
  def handle_event("log_grumant", _params, socket) do
    {:noreply, assign(socket, :logged, "Grumant open")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 13 · Barentsburg capstone board
      </p>

      <h1>Barentsburg capstone board</h1>
      <p class="lede">
        Clerk {@clerk} toggles the Grumant drawer, fades the lamp, and pushes
        a log on the {@craft} board.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p id="logged-grumant">{@logged}</p>

      <button
        id="open-grumant"
        type="button"
        phx-click={
          JS.toggle(to: "#grumant-drawer")
          |> JS.transition("fade-lamp", to: "#coal-lamp")
          |> JS.push("log_grumant")
        }
      >
        Open Grumant
      </button>

      <div id="grumant-drawer">Grumant drawer.</div>
      <p id="coal-lamp">Coal lamp.</p>
    </Layouts.app>
    """
  end
end
