# Function components and HEEx · 09 · Discovery Bay tile board
#
# Teaches:
# - HEEx tracks assigns through @name, not through Map.put/3
# - Map.put on a function-component assigns map freezes that key after first render
# - Phoenix.Component.assign/3 marks the key changed so the template updates
# - An unused parent assign (the bisque pyrometer) does not taint a child
#   that was not passed that assign

defmodule PhoenixMultivitaminWeb.DiscoveryBayTileBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Discovery Bay tile board")
     |> assign(:studio, "Discovery Bay Encaustic · Gardiner")
     |> assign(:tilemaker, "Ione")
     |> assign(:kiln_temp, 1850)
     |> assign(:glaze, "manganese speckled")
     |> assign(:pyrometer_reads, 0)}
  end

  @impl true
  def handle_event("raise_kiln", _params, socket) do
    {:noreply,
     socket
     |> assign(:kiln_temp, socket.assigns.kiln_temp + 25)
     |> assign(:pyrometer_reads, socket.assigns.pyrometer_reads + 1)}
  end

  def handle_event("dip_copper", _params, socket) do
    {:noreply, assign(socket, :glaze, "copper rutile")}
  end

  attr :tile_id, :string, required: true
  attr :glaze, :string, required: true
  attr :kiln_temp, :integer, required: true

  def map_put_chip(assigns) do
    assigns = Map.put(assigns, :fired_pass, "pass-#{System.unique_integer([:positive])}")

    ~H"""
    <p id={"map-put-#{@tile_id}"}>
      <span id={"map-put-pass-#{@tile_id}"}>{@fired_pass}</span>
      · <span id={"map-put-glaze-#{@tile_id}"}>{@glaze}</span>
      · <span id={"map-put-kiln-#{@tile_id}"}>{@kiln_temp}</span>
    </p>
    """
  end

  attr :tile_id, :string, required: true
  attr :glaze, :string, required: true
  attr :kiln_temp, :integer, required: true

  def assign_chip(assigns) do
    assigns = assign(assigns, :fired_pass, "pass-#{System.unique_integer([:positive])}")

    ~H"""
    <p id={"assign-#{@tile_id}"}>
      <span id={"assign-pass-#{@tile_id}"}>{@fired_pass}</span>
      · <span id={"assign-glaze-#{@tile_id}"}>{@glaze}</span>
      · <span id={"assign-kiln-#{@tile_id}"}>{@kiln_temp}</span>
    </p>
    """
  end

  attr :glaze, :string, required: true

  def quiet_chip(assigns) do
    assigns = assign(assigns, :fired_pass, "pass-#{System.unique_integer([:positive])}")

    ~H"""
    <p id="quiet-chip">
      <span id="quiet-pass">{@fired_pass}</span> · <span id="quiet-glaze">{@glaze}</span>
    </p>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 09 · Discovery Bay tile board
      </p>

      <h1>Discovery Bay tile board</h1>
      <p class="lede">
        {@tilemaker} fires encaustic tiles at {@studio}. Three chips share a
        glaze. One writes its firing pass with <code>Map.put/3</code>, one with <code>assign/3</code>, and one is never told the kiln temperature.
      </p>

      <dl class="station-meta">
        <dt>Kiln</dt>
        <dd id="kiln-temp">{@kiln_temp} °F</dd>
        <dt>Pyrometer</dt>
        <dd id="pyrometer-reads">{@pyrometer_reads}</dd>
      </dl>

      <div class="watch-actions">
        <button id="raise-kiln" type="button" phx-click="raise_kiln">Raise kiln 25 °F</button>
        <button id="dip-copper" type="button" phx-click="dip_copper">Dip copper rutile</button>
      </div>

      <div class="scenario">
        <h2>Map.put chip</h2>
        <.map_put_chip tile_id="encaustic" glaze={@glaze} kiln_temp={@kiln_temp} />
        <h2>assign chip</h2>
        <.assign_chip tile_id="encaustic" glaze={@glaze} kiln_temp={@kiln_temp} />
        <h2>Quiet chip</h2>
        <.quiet_chip glaze={@glaze} />
      </div>
    </Layouts.catalog>
    """
  end
end
