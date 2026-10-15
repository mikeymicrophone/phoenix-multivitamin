# Function components and HEEx · 13 · Skokomish weir cards
#
# Teaches:
# - Capstone: attrs, named and inner slots, :for/:if/:let, rest, and class lists
# - Nested components on one weir sheet
# - Flood stage drives a class list; rest carries the panel id through

defmodule PhoenixMultivitaminWeb.SkokomishWeirCardsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Skokomish weir cards")
     |> assign(:weir, "Skokomish River weir · Twana Road")
     |> assign(:counter, "Elsie")
     |> assign(:flood_stage, :ordinary)
     |> assign(:panels, panels())}
  end

  @impl true
  def handle_event("rise_to_flood", _params, socket) do
    {:noreply, assign(socket, :flood_stage, :flood)}
  end

  def handle_event("fall_to_ordinary", _params, socket) do
    {:noreply, assign(socket, :flood_stage, :ordinary)}
  end

  def handle_event("lift_panel_b", _params, socket) do
    panels = Enum.reject(socket.assigns.panels, &(&1.id == "panel-b"))
    {:noreply, assign(socket, :panels, panels)}
  end

  attr :label, :string, required: true
  attr :count, :integer, required: true
  attr :id, :string, required: true

  def species_chip(assigns) do
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
  attr :flood_stage, :atom, required: true, values: [:ordinary, :flood]
  attr :rest, :global, default: %{class: "weir-card"}

  def weir_card(assigns) do
    ~H"""
    <article
      id={@panel.id}
      class={[
        "scenario",
        @flood_stage == :flood && "mount-banner",
        @panel.in_water? && "in-water"
      ]}
      {@rest}
    >
      <h2>Panel {@panel.name}</h2>
      <p id={"#{@panel.id}-note"}>{render_slot(@inner_block, @panel)}</p>
      <p id={"#{@panel.id}-passes"}>
        <.species_chip
          :for={pass <- @pass}
          :if={pass.count > 0}
          id={"#{@panel.id}-#{pass.species}"}
          label={pass.species}
          count={pass.count}
        />
      </p>
      <p id={"#{@panel.id}-watch"}>{render_slot(@watch) || "No night watch posted."}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 13 · Skokomish weir cards
      </p>

      <h1>Skokomish weir cards</h1>
      <p class="lede">
        {@counter} counts the night passage at {@weir}. Each panel is a card
        with attrs, named pass slots, an inner note yielded to <code>:let</code>,
        rest, and a class list that follows flood stage.
      </p>

      <div class="watch-actions">
        <button id="rise-to-flood" type="button" phx-click="rise_to_flood">River in flood</button>
        <button id="fall-to-ordinary" type="button" phx-click="fall_to_ordinary">
          Fall to ordinary
        </button>
        <button id="lift-panel-b" type="button" phx-click="lift_panel_b">Lift panel B</button>
      </div>

      <.weir_card
        :let={posted}
        :for={panel <- @panels}
        :if={panel.in_water?}
        :key={panel.id}
        panel={panel}
        flood_stage={@flood_stage}
        data-crest={panel.crest}
      >
        {posted.name} at {posted.crest}, pickets on {posted.spacing}.
        <:pass species="chinook" count={panel.chinook} />
        <:pass species="coho" count={panel.coho} />
        <:pass species="pink" count={panel.pink} />
        <:watch :if={panel.night_watch}>
          {panel.night_watch} on the catwalk until first light.
        </:watch>
      </.weir_card>
    </Layouts.catalog>
    """
  end

  defp panels do
    [
      %{
        id: "panel-a",
        name: "A",
        crest: "12 in",
        spacing: "1 in pickets",
        in_water?: true,
        chinook: 4,
        coho: 11,
        pink: 0,
        night_watch: "Elsie"
      },
      %{
        id: "panel-b",
        name: "B",
        crest: "10 in",
        spacing: "3/4 in pickets",
        in_water?: true,
        chinook: 1,
        coho: 0,
        pink: 7,
        night_watch: nil
      },
      %{
        id: "panel-c",
        name: "C",
        crest: "dry gravel",
        spacing: "pulled",
        in_water?: false,
        chinook: 0,
        coho: 0,
        pink: 0,
        night_watch: nil
      }
    ]
  end
end
