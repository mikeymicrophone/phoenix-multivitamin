# Function components and HEEx · 13 · Longyearbyen polar cards
#
# Teaches:
# - Capstone: attrs, named and inner slots, :for/:if/:let, rest, and class lists
# - Nested components on one polar sheet
# - Ice stage drives a class list; rest carries the stand id through

defmodule PhoenixMultivitaminWeb.LongyearbyenPolarCardsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Longyearbyen polar cards")
     |> assign(:apron, "Longyearbyen apron · Svalbard")
     |> assign(:clerk, "Toril")
     |> assign(:ice_stage, :bare)
     |> assign(:panels, panels())}
  end

  @impl true
  def handle_event("pack_ice", _params, socket) do
    {:noreply, assign(socket, :ice_stage, :packed)}
  end

  def handle_event("clear_ice", _params, socket) do
    {:noreply, assign(socket, :ice_stage, :bare)}
  end

  def handle_event("lift_stand_b", _params, socket) do
    panels = Enum.reject(socket.assigns.panels, &(&1.id == "panel-b"))
    {:noreply, assign(socket, :panels, panels)}
  end

  attr :label, :string, required: true
  attr :count, :integer, required: true
  attr :id, :string, required: true

  def turn_chip(assigns) do
    ~H"""
    <span id={@id} class="dose-count">{@label} {@count}</span>
    """
  end

  slot :inner_block, required: true

  slot :pass do
    attr :species, :string, required: true
    attr :count, :integer, required: true
  end

  slot :watch

  attr :panel, :map, required: true
  attr :ice_stage, :atom, required: true, values: [:bare, :packed]
  attr :rest, :global, default: %{class: "polar-card"}

  def polar_card(assigns) do
    ~H"""
    <article
      id={@panel.id}
      class={[
        "scenario",
        @ice_stage == :packed && "mount-banner",
        @panel.on_stand? && "on-stand"
      ]}
      {@rest}
    >
      <h2>Stand {@panel.name}</h2>
      <p id={"#{@panel.id}-note"}>{render_slot(@inner_block, @panel)}</p>
      <p id={"#{@panel.id}-passes"}>
        <.turn_chip
          :for={pass <- @pass}
          :if={pass.count > 0}
          id={"#{@panel.id}-#{pass.species}"}
          label={pass.species}
          count={pass.count}
        />
      </p>
      <p id={"#{@panel.id}-watch"}>{render_slot(@watch) || "No night ops posted."}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 13 · Longyearbyen polar cards
      </p>

      <h1>Longyearbyen polar cards</h1>
      <p class="lede">
        {@clerk} counts A320ceo turns at {@apron}. Each stand is a card
        with attrs, named pass slots, an inner note yielded to <code>:let</code>,
        rest, and a class list that follows ice stage.
      </p>

      <div class="watch-actions">
        <button id="pack-ice" type="button" phx-click="pack_ice">Ice packed</button>
        <button id="clear-ice" type="button" phx-click="clear_ice">
          Ice bare
        </button>
        <button id="lift-stand-b" type="button" phx-click="lift_stand_b">Lift stand B</button>
      </div>

      <.polar_card
        :let={posted}
        :for={panel <- @panels}
        :if={panel.on_stand?}
        :key={panel.id}
        panel={panel}
        ice_stage={@ice_stage}
        data-crest={panel.crest}
      >
        {posted.name} at {posted.crest}, chocks on {posted.spacing}.
        <:pass species="inbound" count={panel.inbound} />
        <:pass species="outbound" count={panel.outbound} />
        <:pass species="tech" count={panel.tech} />
        <:watch :if={panel.night_ops}>
          {panel.night_ops} on the apron until first light.
        </:watch>
      </.polar_card>
    </Layouts.catalog>
    """
  end

  defp panels do
    [
      %{
        id: "panel-a",
        name: "A",
        crest: "stand 12",
        spacing: "tow-bar in",
        on_stand?: true,
        inbound: 4,
        outbound: 11,
        tech: 0,
        night_ops: "Toril"
      },
      %{
        id: "panel-b",
        name: "B",
        crest: "stand 10",
        spacing: "tow-bar close",
        on_stand?: true,
        inbound: 1,
        outbound: 0,
        tech: 7,
        night_ops: nil
      },
      %{
        id: "panel-c",
        name: "C",
        crest: "hangared",
        spacing: "pulled",
        on_stand?: false,
        inbound: 0,
        outbound: 0,
        tech: 0,
        night_ops: nil
      }
    ]
  end
end
