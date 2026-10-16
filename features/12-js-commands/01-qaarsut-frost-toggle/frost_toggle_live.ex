# JS commands · 01 · Qaarsut frost toggle
#
# Teaches:
# - JS.toggle/1 on a drawer
# - Timed entrance and exit transitions chained with an attribute update

defmodule PhoenixMultivitaminWeb.QaarsutFrostToggleLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Qaarsut frost toggle", "Paniloo", "Sikorsky S-76")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 01 · Qaarsut frost toggle
      </p>

      <h1>Qaarsut frost toggle</h1>
      <p class="lede">
        Clerk {@clerk} toggles the frost drawer on the {@craft} without a hook.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button
        id="toggle-frost"
        type="button"
        aria-controls="frost-drawer"
        aria-expanded="true"
        phx-click={toggle_frost()}
      >
        Toggle frost
      </button>

      <div id="frost-drawer">Rime on the S-76 blades.</div>
    </Layouts.app>
    """
  end

  defp toggle_frost do
    JS.toggle(
      to: "#frost-drawer",
      in: {"transition ease-out duration-200", "opacity-0 -translate-y-1", "opacity-100 translate-y-0"},
      out: {"transition ease-in duration-200", "opacity-100 translate-y-0", "opacity-0 -translate-y-1"},
      time: 200
    )
    |> JS.toggle_attribute({"aria-expanded", "true", "false"}, to: "#toggle-frost")
  end
end
