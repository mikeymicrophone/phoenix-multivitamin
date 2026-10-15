# Function components and HEEx · 07 · Port Hadlock boat shop cards
#
# Teaches:
# - render_slot/2 passes an argument into :let
# - render_slot/1 with no argument binds nil to :let
# - Optional slots return nil, so || supplies shop-floor fallback copy

defmodule PhoenixMultivitaminWeb.PortHadlockBoatShopCardsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Port Hadlock boat shop cards")
     |> assign(:shop, "Northwest School of Wooden Boatbuilding · Port Hadlock")
     |> assign(:loftsman, "Kerr")
     |> assign(:station, %{name: "midship", timber: "white oak", siding: "7/8 in"})
     |> assign(:varnish_note?, true)}
  end

  @impl true
  def handle_event("move_to_stem", _params, socket) do
    {:noreply,
     assign(socket, :station, %{name: "stem", timber: "purpleheart", siding: "1 1/8 in"})}
  end

  def handle_event("move_to_midship", _params, socket) do
    {:noreply,
     assign(socket, :station, %{name: "midship", timber: "white oak", siding: "7/8 in"})}
  end

  def handle_event("skip_varnish", _params, socket) do
    {:noreply, assign(socket, :varnish_note?, false)}
  end

  slot :inner_block, required: true
  slot :varnish
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
      <h2>Station {@station.name}</h2>
      <p id={"#{@id}-yield"}>
        {render_slot(@inner_block, @argument)}
      </p>
      <p id={"#{@id}-varnish"}>{render_slot(@varnish) || "No varnish scheduled this week."}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 07 · Port Hadlock boat shop cards
      </p>

      <h1>Port Hadlock boat shop cards</h1>
      <p class="lede">
        {@loftsman} lofts a 16-foot Whitehall at {@shop}. The work card yields
        the current station into <code>:let</code>. A second card yields
        nothing, so the same slot prints a fallback. Varnish is an optional
        named slot.
      </p>

      <div class="watch-actions">
        <button id="move-to-stem" type="button" phx-click="move_to_stem">Move to stem</button>
        <button id="move-to-midship" type="button" phx-click="move_to_midship">Move to midship</button>
        <button id="skip-varnish" type="button" phx-click="skip_varnish">Skip varnish note</button>
      </div>

      <.work_card :let={station} id="yield-card" station={@station}>
        Timber {station.timber}, siding {station.siding}, at the {station.name}.
        <:varnish :if={@varnish_note?}>
          Four coats of Epifanes, 24 hours between.
        </:varnish>
      </.work_card>

      <.work_card :let={station} id="nil-card" station={@station} yield_station?={false}>
        {if station, do: "got a station", else: "no station yielded"}
      </.work_card>
    </Layouts.catalog>
    """
  end
end
