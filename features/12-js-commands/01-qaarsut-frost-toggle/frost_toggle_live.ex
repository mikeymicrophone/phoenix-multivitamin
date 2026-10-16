# JS commands · 01 · Qaarsut frost toggle
#
# Teaches:
# - JS.toggle/1 on a drawer

defmodule PhoenixMultivitaminWeb.QaarsutFrostToggleLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Qaarsut frost toggle")
     |> assign(:clerk, "Paniloo")
     |> assign(:craft, "Sikorsky S-76")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 01 · Qaarsut frost toggle
      </p>

      <h1>Qaarsut frost toggle</h1>
      <p class="lede">
        Clerk {@clerk} toggles the frost drawer on the {@craft} without a hook.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="toggle-frost" type="button" phx-click={JS.toggle(to: "#frost-drawer")}>
        Toggle frost
      </button>

      <div id="frost-drawer">Rime on the S-76 blades.</div>
    </Layouts.catalog>
    """
  end
end
