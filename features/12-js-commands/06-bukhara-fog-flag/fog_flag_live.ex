# JS commands · 06 · Bukhara fog flag
#
# Teaches:
# - JS.set_attribute/1 on a fog flag

defmodule PhoenixMultivitaminWeb.BukharaFogFlagLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Bukhara fog flag", "Nodira", "Antonov An-140")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 06 · Bukhara fog flag
      </p>

      <h1>Bukhara fog flag</h1>
      <p class="lede">
        Clerk {@clerk} sets a fog attribute on the {@craft} flag.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button
        id="set-fog"
        type="button"
        phx-click={JS.set_attribute({"data-fog", "thick"}, to: "#fog-flag")}
      >
        Set thick fog
      </button>

      <p id="fog-flag" data-fog="clear">Kalyan fog flag.</p>
    </Layouts.app>
    """
  end
end
