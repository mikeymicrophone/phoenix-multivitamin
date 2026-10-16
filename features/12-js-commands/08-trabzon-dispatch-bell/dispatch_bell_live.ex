# JS commands · 08 · Trabzon dispatch bell
#
# Teaches:
# - JS.dispatch/1 of a custom event

defmodule PhoenixMultivitaminWeb.TrabzonDispatchBellLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Trabzon dispatch bell", "Aylin", "Airbus A310")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 08 · Trabzon dispatch bell
      </p>

      <h1>Trabzon dispatch bell</h1>
      <p class="lede">
        Clerk {@clerk} dispatches a chime event toward the {@craft} bell.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button
        id="strike-chime"
        type="button"
        phx-click={JS.dispatch("fuel-chime", to: "#chime-bell", detail: %{stand: "east"})}
      >
        Strike chime
      </button>

      <p id="chime-bell">Pontic chime.</p>
    </Layouts.app>
    """
  end
end
