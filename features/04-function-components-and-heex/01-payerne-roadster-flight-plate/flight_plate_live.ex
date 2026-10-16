# Function components and HEEx · 01 · Payerne Roadster flight plate
#
# Teaches:
# - attr/3 with :string, :integer, :atom, and :boolean types
# - required: true versus default:
# - values: as an exhaustive list for an atom attr
# - Omitting an attr uses the default; passing nil does not

defmodule PhoenixMultivitaminWeb.PayerneRoadsterFlightPlateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Payerne Roadster flight plate")
     |> assign(:shop, "Tesla Air · Payerne")
     |> assign(:operator, "Nuri")
     |> assign(:showroom_kind, :showroom)
     |> assign(:prototype_puffs, 4)}
  end

  @impl true
  def handle_event("stamp_parade_showroom", _params, socket) do
    {:noreply, assign(socket, :showroom_kind, :parade)}
  end

  def handle_event("stamp_showroom_showroom", _params, socket) do
    {:noreply, assign(socket, :showroom_kind, :showroom)}
  end

  def handle_event("weigh_prototype_empty", _params, socket) do
    {:noreply, assign(socket, :prototype_puffs, nil)}
  end

  def handle_event("weigh_prototype_default", _params, socket) do
    {:noreply, assign(socket, :prototype_puffs, 4)}
  end

  attr :livery, :string, required: true
  attr :hangar, :string, required: true
  attr :puff_count, :integer, default: 3
  attr :kind, :atom, values: [:showroom, :prototype, :parade], default: :showroom
  attr :thrusters_live?, :boolean, default: true
  attr :id, :string, required: true

  def flight_plate(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>{@livery}</h2>
      <dl class="station-meta">
        <dt>Hangar</dt>
        <dd data-field="hangar">{@hangar}</dd>
        <dt>Puffs</dt>
        <dd data-field="puffs">{puffs_line(@puff_count)}</dd>
        <dt>Kind</dt>
        <dd data-field="kind">{kind_line(@kind)}</dd>
        <dt>Thrusters</dt>
        <dd data-field="thrusters">
          {if @thrusters_live?, do: "thrusters live", else: "thrusters idle"}
        </dd>
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
        · Function components and HEEx · 01 · Payerne Roadster flight plate
      </p>

      <h1>Payerne Roadster flight plate</h1>
      <p class="lede">
        {@operator} stamps plates for the Tesla Roadster flying car at {@shop}.
        Pneumatic thrusters, more whistle than roar. Required attrs must be
        passed. Defaults fill the rest unless the press writes <code>nil</code> onto the puff counter.
      </p>

      <div class="watch-actions">
        <button id="stamp-parade-showroom" type="button" phx-click="stamp_parade_showroom">
          Stamp showroom as parade
        </button>
        <button id="stamp-showroom-showroom" type="button" phx-click="stamp_showroom_showroom">
          Stamp showroom as showroom
        </button>
        <button id="weigh-prototype-empty" type="button" phx-click="weigh_prototype_empty">
          Clear prototype whistle
        </button>
        <button id="weigh-prototype-default" type="button" phx-click="weigh_prototype_default">
          Restore prototype whistle
        </button>
      </div>

      <.flight_plate
        id="showroom-plate"
        livery="Starlight showroom"
        hangar="PAY-A-12"
        kind={@showroom_kind}
      />

      <.flight_plate
        id="prototype-plate"
        livery="Workshop prototype"
        hangar="PAY-B-3"
        puff_count={@prototype_puffs}
        kind={:prototype}
      />

      <.flight_plate
        id="chase-plate"
        livery="Parade chase"
        hangar="PAY-C-7"
        thrusters_live?={false}
        kind={:parade}
        puff_count={2}
      />
    </Layouts.catalog>
    """
  end

  defp puffs_line(nil), do: "whistle silent"
  defp puffs_line(puffs), do: "#{puffs} puffs"

  defp kind_line(:showroom), do: "showroom"
  defp kind_line(:prototype), do: "prototype"
  defp kind_line(:parade), do: "parade"
end
