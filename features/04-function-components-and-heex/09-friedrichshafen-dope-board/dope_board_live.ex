# Function components and HEEx · 09 · Friedrichshafen dope board
#
# Teaches:
# - HEEx tracks assigns through @name, not through Map.put/3
# - Map.put on a function-component assigns map freezes that key after first render
# - Phoenix.Component.assign/3 marks the key changed so the template updates
# - An unused parent assign (the loft thermometer) does not taint a child
#   that was not passed that assign

defmodule PhoenixMultivitaminWeb.FriedrichshafenDopeBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Friedrichshafen dope board")
     |> assign(:studio, "Zeppelin NT loft · Friedrichshafen")
     |> assign(:tech, "Klara")
     |> assign(:loft_temp, 1850)
     |> assign(:tint, "clear tautening")
     |> assign(:thermometer_reads, 0)}
  end

  @impl true
  def handle_event("raise_loft", _params, socket) do
    {:noreply,
     socket
     |> assign(:loft_temp, socket.assigns.loft_temp + 25)
     |> assign(:thermometer_reads, socket.assigns.thermometer_reads + 1)}
  end

  def handle_event("dip_aluminium", _params, socket) do
    {:noreply, assign(socket, :tint, "aluminium pigment")}
  end

  attr :chip_id, :string, required: true
  attr :tint, :string, required: true
  attr :loft_temp, :integer, required: true

  def map_put_chip(assigns) do
    assigns = Map.put(assigns, :fired_pass, "pass-#{System.unique_integer([:positive])}")

    ~H"""
    <p id={"map-put-#{@chip_id}"}>
      <span id={"map-put-pass-#{@chip_id}"}>{@fired_pass}</span>
      · <span id={"map-put-tint-#{@chip_id}"}>{@tint}</span>
      · <span id={"map-put-loft-#{@chip_id}"}>{@loft_temp}</span>
    </p>
    """
  end

  attr :chip_id, :string, required: true
  attr :tint, :string, required: true
  attr :loft_temp, :integer, required: true

  def assign_chip(assigns) do
    assigns = assign(assigns, :fired_pass, "pass-#{System.unique_integer([:positive])}")

    ~H"""
    <p id={"assign-#{@chip_id}"}>
      <span id={"assign-pass-#{@chip_id}"}>{@fired_pass}</span>
      · <span id={"assign-tint-#{@chip_id}"}>{@tint}</span>
      · <span id={"assign-loft-#{@chip_id}"}>{@loft_temp}</span>
    </p>
    """
  end

  attr :tint, :string, required: true

  def quiet_chip(assigns) do
    assigns = assign(assigns, :fired_pass, "pass-#{System.unique_integer([:positive])}")

    ~H"""
    <p id="quiet-chip">
      <span id="quiet-pass">{@fired_pass}</span> · <span id="quiet-tint">{@tint}</span>
    </p>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 09 · Friedrichshafen dope board
      </p>

      <h1>Friedrichshafen dope board</h1>
      <p class="lede">
        {@tech} dopes Zeppelin NT fabric at {@studio}. Three chips share a
        tint. One writes its firing pass with <code>Map.put/3</code>, one with <code>assign/3</code>, and one is never told the loft temperature.
      </p>

      <dl class="station-meta">
        <dt>Loft</dt>
        <dd id="loft-temp">{@loft_temp} °F</dd>
        <dt>Thermometer</dt>
        <dd id="thermometer-reads">{@thermometer_reads}</dd>
      </dl>

      <div class="watch-actions">
        <button id="raise-loft" type="button" phx-click="raise_loft">Raise loft 25 °F</button>
        <button id="dip-aluminium" type="button" phx-click="dip_aluminium">Dip aluminium pigment</button>
      </div>

      <div class="scenario">
        <h2>Map.put chip</h2>
        <.map_put_chip chip_id="envelope" tint={@tint} loft_temp={@loft_temp} />
        <h2>assign chip</h2>
        <.assign_chip chip_id="envelope" tint={@tint} loft_temp={@loft_temp} />
        <h2>Quiet chip</h2>
        <.quiet_chip tint={@tint} />
      </div>
    </Layouts.catalog>
    """
  end
end
