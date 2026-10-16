# JS commands · 10 · Tulcea pipe board
#
# Teaches:
# - Composing commands with the pipe

defmodule PhoenixMultivitaminWeb.TulceaPipeBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Tulcea pipe board", "Doina", "Saab 2000")
     |> assign(:marked, "quiet")}
  end

  @impl true
  def handle_event("mark_lit", _params, socket) do
    {:noreply, assign(socket, :marked, "lit")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 10 · Tulcea pipe board
      </p>

      <h1>Tulcea pipe board</h1>
      <p class="lede">
        Clerk {@clerk} pipes show, class, and push for the {@craft} delta card.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p id="marked-card">{@marked}</p>

      <button
        id="pipe-delta"
        type="button"
        phx-click={
          JS.show(to: "#delta-card")
          |> JS.add_class("lit", to: "#delta-card")
          |> JS.push("mark_lit")
        }
      >
        Light the delta
      </button>

      <p id="delta-card" hidden>Danube delta card.</p>
    </Layouts.app>
    """
  end
end
