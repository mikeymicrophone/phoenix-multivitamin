# Function components and HEEx · 08 · Derby Trent heat slips
#
# Teaches:
# - A function component that renders another function component
# - Assigns do not leak: a child only sees what the parent passed
# - Nested composition of heat_slip → stage_row → alloy_chip

defmodule PhoenixMultivitaminWeb.DerbyTrentHeatSlipsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Derby Trent heat slips")
     |> assign(:works, "Rolls-Royce · Derby")
     |> assign(:fitter, "Gareth")
     |> assign(:heats, [
       %{
         id: "heat-14",
         cell: "XWB cell three",
         metal: "Trent remelt",
         stages: [
           %{stage: "ip turbine", alloy: "IP billet", lbs: 420},
           %{stage: "lp compressor", alloy: "LP billet", lbs: 180}
         ]
       }
     ])}
  end

  @impl true
  def handle_event("add_fan_stage", _params, socket) do
    heats =
      Enum.map(socket.assigns.heats, fn
        %{id: "heat-14"} = heat ->
          stages = heat.stages ++ [%{stage: "fan case", alloy: "fan billet", lbs: 640}]
          %{heat | stages: stages}

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

  attr :stage, :string, required: true
  attr :alloy, :string, required: true
  attr :lbs, :integer, required: true
  attr :id, :string, required: true

  def stage_row(assigns) do
    ~H"""
    <li id={@id}>
      {@stage} · {@lbs} lb <.alloy_chip id={"#{@id}-alloy"} label={@alloy} />
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
      <p>{@heat.cell} · {@heat.metal}</p>
      <p :if={@inner_block != []} id={"#{@id}-note"}>{render_slot(@inner_block)}</p>
      <ol id={"#{@id}-stages"} class="watch-log">
        <.stage_row
          :for={row <- @heat.stages}
          id={"#{@id}-#{row.stage |> String.replace(" ", "-")}"}
          stage={row.stage}
          alloy={row.alloy}
          lbs={row.lbs}
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
        · Function components and HEEx · 08 · Derby Trent heat slips
      </p>

      <h1>Derby Trent heat slips</h1>
      <p class="lede">
        {@fitter} fits the Trent XWB at {@works}. A heat slip renders stage
        rows. Each stage row renders an alloy chip. Nothing leaks: the chip
        never sees the cell name unless the row passes it.
      </p>

      <div class="watch-actions">
        <button id="add-fan-stage" type="button" phx-click="add_fan_stage">Add fan-case stage</button>
      </div>

      <.heat_slip :for={heat <- @heats} id={heat.id} heat={heat}>
        Charge Trent remelt, blast on at 4:10 a.m.
      </.heat_slip>
    </Layouts.catalog>
    """
  end
end
