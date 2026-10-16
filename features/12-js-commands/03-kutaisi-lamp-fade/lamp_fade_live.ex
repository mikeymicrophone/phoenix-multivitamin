# JS commands · 03 · Kutaisi lamp fade
#
# Teaches:
# - JS.transition/1 for a lamp that fades
# - A transition tuple with explicit duration and nonblocking execution

defmodule PhoenixMultivitaminWeb.KutaisiLampFadeLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Kutaisi lamp fade", "Tamari", "Embraer ERJ-145")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 03 · Kutaisi lamp fade
      </p>

      <h1>Kutaisi lamp fade</h1>
      <p class="lede">
        Clerk {@clerk} fades the threshold lamp on the {@craft}.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button
        id="fade-lamp"
        type="button"
        phx-click={
          JS.transition(
            {"transition-opacity ease-out", "opacity-100", "opacity-30"},
            to: "#threshold-lamp",
            time: 700,
            blocking: false
          )
        }
      >
        Fade lamp
      </button>

      <p id="threshold-lamp">Threshold bar lit.</p>
    </Layouts.app>
    """
  end
end
