# Function components and HEEx · 05 · Tianjin assembly tickets
#
# Teaches:
# - attr :rest, :global with a default map
# - include: extra names on the global set
# - Caller class replaces the rest default class (map merge), it does not concatenate
# - A static class on the same tag as {@rest} emits a second class attribute;
#   the HTML parser keeps the first and the rest class is dropped

defmodule PhoenixMultivitaminWeb.TianjinAssemblyTicketsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Tianjin assembly tickets")
     |> assign(:plant, "Airbus Final Assembly · Tianjin")
     |> assign(:scaler, "Wei")
     |> assign(:wing_rush?, false)
     |> assign(:fuselage_disabled?, false)}
  end

  @impl true
  def handle_event("mark_wing_rush", _params, socket) do
    {:noreply, assign(socket, :wing_rush?, true)}
  end

  def handle_event("clear_wing_rush", _params, socket) do
    {:noreply, assign(socket, :wing_rush?, false)}
  end

  def handle_event("hold_fuselage_ticket", _params, socket) do
    {:noreply, assign(socket, :fuselage_disabled?, true)}
  end

  attr :variant, :string, required: true
  attr :frame_hours, :integer, required: true
  attr :dolly, :string, required: true
  attr :id, :string, required: true

  attr :rest, :global,
    default: %{class: "join-ticket"},
    include: ~w(disabled form)

  def join_ticket(assigns) do
    ~H"""
    <article id={@id} {@rest}>
      <h2>{@variant}</h2>
      <dl class="station-meta">
        <dt>Frame hours</dt>
        <dd data-field="frame-hours">{@frame_hours}</dd>
        <dt>Dolly</dt>
        <dd data-field="dolly">{@dolly}</dd>
      </dl>
    </article>
    """
  end

  attr :variant, :string, required: true
  attr :frame_hours, :integer, required: true
  attr :dolly, :string, required: true
  attr :id, :string, required: true
  attr :rest, :global, default: %{class: "join-ticket"}

  def competing_class_ticket(assigns) do
    ~H"""
    <article id={@id} class="bay-slip" {@rest}>
      <h2>{@variant}</h2>
      <p>Dolly {@dolly} · {@frame_hours} h</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 05 · Tianjin assembly tickets
      </p>

      <h1>Tianjin assembly tickets</h1>
      <p class="lede">
        {@scaler} scales A320neo joins at {@plant}. Global attrs ride on <code>:rest</code>. The default class is <code>join-ticket</code>.
        A caller class replaces that default. <code>disabled</code> is included
        so the fuselage ticket can be held at the gate.
      </p>

      <div class="watch-actions">
        <button id="mark-wing-rush" type="button" phx-click="mark_wing_rush">
          Mark wing rush
        </button>
        <button id="clear-wing-rush" type="button" phx-click="clear_wing_rush">
          Clear wing rush
        </button>
        <button id="hold-fuselage-ticket" type="button" phx-click="hold_fuselage_ticket">
          Hold fuselage ticket
        </button>
      </div>

      <.join_ticket
        :if={@wing_rush?}
        id="wing-ticket"
        variant="A320neo wing join"
        frame_hours={4_820}
        dolly="TJ-441"
        data-bunk="three"
        class="rush-load"
      />
      <.join_ticket
        :if={not @wing_rush?}
        id="wing-ticket"
        variant="A320neo wing join"
        frame_hours={4_820}
        dolly="TJ-441"
        data-bunk="three"
      />

      <.join_ticket
        id="fuselage-ticket"
        variant="A320neo fuselage join"
        frame_hours={6_100}
        dolly="TJ-18"
        disabled={@fuselage_disabled?}
      />

      <.competing_class_ticket
        id="empennage-ticket"
        variant="A320neo empennage join"
        frame_hours={2_240}
        dolly="TJ-9"
      />
    </Layouts.catalog>
    """
  end
end
