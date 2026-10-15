# Function components and HEEx · 05 · Port Angeles mill tickets
#
# Teaches:
# - attr :rest, :global with a default map
# - include: extra names on the global set
# - Caller class replaces the rest default class (map merge), it does not concatenate
# - A static class on the same tag as {@rest} is a second class attribute

defmodule PhoenixMultivitaminWeb.PortAngelesMillTicketsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Port Angeles mill tickets")
     |> assign(:mill, "Interfor · Port Angeles")
     |> assign(:scaler, "Edie")
     |> assign(:hemlock_rush?, false)
     |> assign(:fir_disabled?, false)}
  end

  @impl true
  def handle_event("mark_hemlock_rush", _params, socket) do
    {:noreply, assign(socket, :hemlock_rush?, true)}
  end

  def handle_event("clear_hemlock_rush", _params, socket) do
    {:noreply, assign(socket, :hemlock_rush?, false)}
  end

  def handle_event("hold_fir_ticket", _params, socket) do
    {:noreply, assign(socket, :fir_disabled?, true)}
  end

  attr :species, :string, required: true
  attr :board_feet, :integer, required: true
  attr :truck, :string, required: true
  attr :id, :string, required: true

  attr :rest, :global,
    default: %{class: "mill-ticket"},
    include: ~w(disabled form)

  def mill_ticket(assigns) do
    ~H"""
    <article id={@id} class="scale-slip" {@rest}>
      <h2>{@species}</h2>
      <dl class="station-meta">
        <dt>Board feet</dt>
        <dd data-field="board-feet">{@board_feet}</dd>
        <dt>Truck</dt>
        <dd data-field="truck">{@truck}</dd>
      </dl>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 05 · Port Angeles mill tickets
      </p>

      <h1>Port Angeles mill tickets</h1>
      <p class="lede">
        {@scaler} scales loads at {@mill}. Global attrs ride on <code>:rest</code>. The default class is <code>mill-ticket</code>.
        A caller class replaces that default. <code>disabled</code> is included
        so the fir ticket can be held at the gate.
      </p>

      <div class="watch-actions">
        <button id="mark-hemlock-rush" type="button" phx-click="mark_hemlock_rush">
          Mark hemlock rush
        </button>
        <button id="clear-hemlock-rush" type="button" phx-click="clear_hemlock_rush">
          Clear hemlock rush
        </button>
        <button id="hold-fir-ticket" type="button" phx-click="hold_fir_ticket">
          Hold fir ticket
        </button>
      </div>

      <.mill_ticket
        :if={@hemlock_rush?}
        id="hemlock-ticket"
        species="Western hemlock"
        board_feet={4_820}
        truck="PA-441"
        data-bunk="three"
        class="rush-load"
      />
      <.mill_ticket
        :if={not @hemlock_rush?}
        id="hemlock-ticket"
        species="Western hemlock"
        board_feet={4_820}
        truck="PA-441"
        data-bunk="three"
      />

      <.mill_ticket
        id="fir-ticket"
        species="Douglas-fir"
        board_feet={6_100}
        truck="PA-18"
        disabled={@fir_disabled?}
      />
    </Layouts.catalog>
    """
  end
end
