# Function components and HEEx · 01 · Seed packet label press
#
# Teaches:
# - attr/3 with :string, :integer, :atom, and :boolean types
# - required: true versus default:
# - values: as an exhaustive list for an atom attr
# - Omitting an attr uses the default; passing nil does not

defmodule PhoenixMultivitaminWeb.SeedPacketLabelPressLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Seed packet label press")
     |> assign(:press, "Nash's Organic Produce · Sequim")
     |> assign(:operator, "Linnea")
     |> assign(:chioggia_kind, :heirloom)
     |> assign(:lima_grams, 4)}
  end

  @impl true
  def handle_event("stamp_hybrid_chioggia", _params, socket) do
    {:noreply, assign(socket, :chioggia_kind, :hybrid)}
  end

  def handle_event("stamp_heirloom_chioggia", _params, socket) do
    {:noreply, assign(socket, :chioggia_kind, :heirloom)}
  end

  def handle_event("weigh_lima_empty", _params, socket) do
    {:noreply, assign(socket, :lima_grams, nil)}
  end

  def handle_event("weigh_lima_default", _params, socket) do
    {:noreply, assign(socket, :lima_grams, 4)}
  end

  attr :variety, :string, required: true
  attr :lot, :string, required: true
  attr :grams, :integer, default: 3
  attr :kind, :atom, values: [:heirloom, :open_pollinated, :hybrid], default: :heirloom
  attr :organic?, :boolean, default: true
  attr :id, :string, required: true

  def packet_label(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>{@variety}</h2>
      <dl class="station-meta">
        <dt>Lot</dt>
        <dd data-field="lot">{@lot}</dd>
        <dt>Weight</dt>
        <dd data-field="grams">{grams_line(@grams)}</dd>
        <dt>Kind</dt>
        <dd data-field="kind">{kind_line(@kind)}</dd>
        <dt>Organic</dt>
        <dd data-field="organic">{if @organic?, do: "certified organic", else: "not claimed"}</dd>
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
        · Function components and HEEx · 01 · Seed packet label press
      </p>

      <h1>Seed packet label press</h1>
      <p class="lede">
        {@operator} runs the Heidelberg platen at {@press}. Each packet is a
        function component. Required attrs must be passed. Defaults fill the
        rest unless the press writes <code>nil</code> onto the scale.
      </p>

      <div class="watch-actions">
        <button id="stamp-hybrid-chioggia" type="button" phx-click="stamp_hybrid_chioggia">
          Stamp Chioggia as hybrid
        </button>
        <button id="stamp-heirloom-chioggia" type="button" phx-click="stamp_heirloom_chioggia">
          Stamp Chioggia as heirloom
        </button>
        <button id="weigh-lima-empty" type="button" phx-click="weigh_lima_empty">
          Clear lima scale
        </button>
        <button id="weigh-lima-default" type="button" phx-click="weigh_lima_default">
          Restore lima scale
        </button>
      </div>

      <.packet_label
        id="chioggia-packet"
        variety="Chioggia beet"
        lot="NASH-24-081"
        kind={@chioggia_kind}
      />

      <.packet_label
        id="lima-packet"
        variety="Des Moines lima"
        lot="NASH-24-114"
        grams={@lima_grams}
        kind={:open_pollinated}
      />

      <.packet_label
        id="lettuce-packet"
        variety="Winter Density lettuce"
        lot="NASH-24-203"
        organic?={false}
        kind={:hybrid}
        grams={2}
      />
    </Layouts.catalog>
    """
  end

  defp grams_line(nil), do: "scale empty"
  defp grams_line(grams), do: "#{grams} g"

  defp kind_line(:heirloom), do: "heirloom"
  defp kind_line(:open_pollinated), do: "open-pollinated"
  defp kind_line(:hybrid), do: "hybrid"
end
