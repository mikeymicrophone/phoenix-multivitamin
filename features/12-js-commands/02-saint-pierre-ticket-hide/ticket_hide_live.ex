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
     |> assign(:page_title, "Saint-Pierre ticket hide")
     |> assign(:clerk, "Léonie")
     |> assign(:craft, "Reims F406")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 02 · Saint-Pierre ticket hide
      </p>

      <h1>Saint-Pierre ticket hide</h1>
      <p class="lede">
        Clerk {@clerk} shows and hides the {@craft} drift ticket.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="show-ticket" type="button" phx-click={JS.show(to: "#drift-ticket")}>
        Show ticket
      </button>
      <button id="hide-ticket" type="button" phx-click={JS.hide(to: "#drift-ticket")}>
        Hide ticket
      </button>

      <p id="drift-ticket">Crosswind 18 on the Miquelon lane.</p>
    </Layouts.catalog>
    """
  end
end
