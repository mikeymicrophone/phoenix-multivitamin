# Function components and HEEx · 07 · Hahnweide work cards
#
# Teaches:
# - render_slot/2 passes an argument into :let
# - render_slot/1 with no argument binds nil to :let
# - Optional slots return nil, so || supplies shop-floor fallback copy

defmodule PhoenixMultivitaminWeb.HahnweideWorkCardsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Hahnweide work cards")
     |> assign(:shop, "Hahnweide · Kirchheim")
     |> assign(:rigger, "Jutta")
     |> assign(:station, %{name: "rib", timber: "spruce", siding: "7/8 in"})
     |> assign(:dope_note?, true)}
  end

  @impl true
  def handle_event("move_to_leading_edge", _params, socket) do
    {:noreply,
     assign(socket, :station, %{name: "leading-edge", timber: "ash", siding: "1 1/8 in"})}
  end

  def handle_event("move_to_rib", _params, socket) do
    {:noreply,
     assign(socket, :station, %{name: "rib", timber: "spruce", siding: "7/8 in"})}
  end

  def handle_event("skip_dope", _params, socket) do
    {:noreply, assign(socket, :dope_note?, false)}
  end

  slot :inner_block, required: true
  slot :dope
  attr :id, :string, required: true
  attr :station, :map, required: true
  attr :yield_station?, :boolean, default: true

  def work_card(assigns) do
    assigns =
      assign(
        assigns,
        :argument,
        if(assigns.yield_station?, do: assigns.station)
      )

    ~H"""
    <article id={@id} class="scenario">
      <h2>Bay {@station.name}</h2>
      <p id={"#{@id}-yield"}>
        {render_slot(@inner_block, @argument)}
      </p>
      <p id={"#{@id}-dope"}>{render_slot(@dope) || "No dope scheduled this week."}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 07 · Hahnweide work cards
      </p>

      <h1>Hahnweide work cards</h1>
      <p class="lede">
        {@rigger} rigs a Bücker Jungmann at {@shop}. The work card yields
        the current bay into <code>:let</code>. A second card yields
        nothing, so the same slot prints a fallback. Dope is an optional
        named slot.
      </p>

      <div class="watch-actions">
        <button id="move-to-leading-edge" type="button" phx-click="move_to_leading_edge">
          Move to leading-edge
        </button>
        <button id="move-to-rib" type="button" phx-click="move_to_rib">Move to rib</button>
        <button id="skip-dope" type="button" phx-click="skip_dope">Skip dope note</button>
      </div>

      <.work_card :let={station} id="yield-card" station={@station}>
        Timber {station.timber}, siding {station.siding}, at the {station.name}.
        <:dope :if={@dope_note?}>
          Four coats of nitrate, 24 hours between.
        </:dope>
      </.work_card>

      <.work_card :let={station} id="nil-card" station={@station} yield_station?={false}>
        {if station, do: "got a station", else: "no station yielded"}
      </.work_card>
    </Layouts.catalog>
    """
  end
end
