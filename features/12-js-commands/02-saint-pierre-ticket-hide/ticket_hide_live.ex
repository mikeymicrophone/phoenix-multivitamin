# JS commands · 02 · Saint-Pierre ticket hide
#
# Teaches:
# - JS.show/1 and JS.hide/1 on a ticket

defmodule PhoenixMultivitaminWeb.SaintPierreTicketHideLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Saint-Pierre ticket hide", "Léonie", "Reims F406")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 02 · Saint-Pierre ticket hide
      </p>

      <h1>Saint-Pierre ticket hide</h1>
      <p class="lede">
        Clerk {@clerk} shows and hides the {@craft} drift ticket.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button id="show-ticket" type="button" phx-click={JS.show(to: "#drift-ticket")}>
        Show ticket
      </button>
      <button id="hide-ticket" type="button" phx-click={JS.hide(to: "#drift-ticket")}>
        Hide ticket
      </button>

      <p id="drift-ticket">Crosswind 18 on the Miquelon lane.</p>
    </Layouts.app>
    """
  end
end
