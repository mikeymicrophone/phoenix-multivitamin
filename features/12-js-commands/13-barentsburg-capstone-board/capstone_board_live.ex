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
     |> assign(:page_title, "Barentsburg capstone board")
     |> assign(:clerk, "Lars")
     |> assign(:craft, "Eurocopter AS332 Super Puma")
     |> assign(:logged, "quiet")}
  end

  @impl true
  def handle_event("log_grumant", _params, socket) do
    {:noreply, assign(socket, :logged, "Grumant open")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 13 · Barentsburg capstone board
      </p>

      <h1>Barentsburg capstone board</h1>
      <p class="lede">
        Clerk {@clerk} toggles the Grumant drawer, fades the lamp, and pushes
        a log on the {@craft} board.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
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
    </Layouts.catalog>
    """
  end
end
