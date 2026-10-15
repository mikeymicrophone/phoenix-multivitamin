# Function components and HEEx · 08 · Irondale foundry heat slips
#
# Teaches:
# - A function component that renders another function component
# - Assigns do not leak: a child only sees what the parent passed
# - Nested composition of heat_slip → pour_row → alloy_chip

defmodule PhoenixMultivitaminWeb.IrondaleFoundryHeatSlipsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Irondale foundry heat slips")
     |> assign(:foundry, "Irondale Furnace · Port Hadlock")
     |> assign(:founder, "Bessa")
     |> assign(:heats, [
       %{
         id: "heat-14",
         cupola: "east stack",
         iron: "charcoal pig",
         pours: [
           %{mould: "try-pot", alloy: "No. 2 foundry", lbs: 420},
           %{mould: "sash weight", alloy: "silvery pig", lbs: 180}
         ]
       }
     ])}
  end

  @impl true
  def handle_event("add_keel_pour", _params, socket) do
    heats =
      Enum.map(socket.assigns.heats, fn
        %{id: "heat-14"} = heat ->
          pours = heat.pours ++ [%{mould: "keel block", alloy: "low-phos", lbs: 640}]
          %{heat | pours: pours}

        heat ->
          heat
      end)

    {:noreply, assign(socket, :heats, heats)}
  end

  attr :label, :string, required: true
  attr :id, :string, required: true

  def alloy_chip(assigns) do
    ~H"""
    <span id={@id} class="dose-count">{@label}</span>
    """
  end

  attr :mould, :string, required: true
  attr :alloy, :string, required: true
  attr :lbs, :integer, required: true
  attr :id, :string, required: true

  def pour_row(assigns) do
    ~H"""
    <li id={@id}>
      {@mould} · {@lbs} lb <.alloy_chip id={"#{@id}-alloy"} label={@alloy} />
    </li>
    """
  end

  attr :heat, :map, required: true
  attr :id, :string, required: true
  slot :inner_block

  def heat_slip(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>Heat {String.replace(@heat.id, "heat-", "")}</h2>
      <p>{@heat.cupola} · {@heat.iron}</p>
      <p :if={@inner_block != []} id={"#{@id}-note"}>{render_slot(@inner_block)}</p>
      <ol id={"#{@id}-pours"} class="watch-log">
        <.pour_row
          :for={pour <- @heat.pours}
          id={"#{@id}-#{pour.mould |> String.replace(" ", "-")}"}
          mould={pour.mould}
          alloy={pour.alloy}
          lbs={pour.lbs}
        />
      </ol>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 08 · Irondale foundry heat slips
      </p>

      <h1>Irondale foundry heat slips</h1>
      <p class="lede">
        {@founder} charges the cupola at {@foundry}. A heat slip renders pour
        rows. Each pour row renders an alloy chip. Nothing leaks: the chip
        never sees the cupola name unless the row passes it.
      </p>

      <div class="watch-actions">
        <button id="add-keel-pour" type="button" phx-click="add_keel_pour">Add keel-block pour</button>
      </div>

      <.heat_slip :for={heat <- @heats} id={heat.id} heat={heat}>
        Charge charcoal pig, blast on at 4:10 a.m.
      </.heat_slip>
    </Layouts.catalog>
    """
  end
end
