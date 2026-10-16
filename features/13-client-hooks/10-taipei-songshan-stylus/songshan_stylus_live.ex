# Client hooks · 10 · Taipei Songshan stylus
#
# Teaches:
# - ResizeObserver sizes a native canvas widget; AbortController and disconnect clean up browser resources.
# - A bounded list payload is folded with Enum.reduce_while/3, rejecting an entire malformed stroke.
# - Pointer pressure and a keyboard-accessible calibration button share one reply contract.

defmodule PhoenixMultivitaminWeb.TaipeiSongshanStylusLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Taipei Songshan stylus", "Mei-ling", "ATR 72-600")
     |> assign(stroke_count: 0, pressure_status: "Draw a stylus calibration stroke")}
  end

  @impl true
  def handle_event("record_stylus", %{"pressures" => pressures}, socket)
      when is_list(pressures) and length(pressures) in 1..64 do
    pressure_summary =
      Enum.reduce_while(pressures, {:ok, 0, 0}, fn
        pressure, {:ok, total, peak} when is_integer(pressure) and pressure in 0..100 ->
          {:cont, {:ok, total + pressure, max(peak, pressure)}}

        _pressure, _summary ->
          {:halt, {:error, :invalid_pressure}}
      end)

    case pressure_summary do
      {:ok, total, peak} ->
        average = Float.round(total / length(pressures), 1)

        {:reply, %{accepted: true, average: average, peak: peak},
         socket
         |> update(:stroke_count, &(&1 + 1))
         |> assign(:pressure_status, "Peak pressure #{peak}%; mean #{average}%")}

      {:error, :invalid_pressure} ->
        {:reply, %{accepted: false, reason: "invalid_pressure"}, socket}
    end
  end

  def handle_event("record_stylus", _params, socket) do
    {:reply, %{accepted: false, reason: "stroke_size"}, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 10 · Taipei Songshan stylus
      </p>

      <h1>Taipei Songshan stylus</h1>
      <p class="lede">
        Maintenance recorder {@clerk} checks a pressure-sensitive stylus before signing the
        {@craft} trim card at Songshan.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div id="songshan-stylus" phx-hook=".PressureStylus" phx-update="ignore" class="scenario mt-6">
        <canvas width="600" height="180" class="w-full touch-none" role="img"
          aria-label="Stylus pressure calibration pad">Stylus calibration pad.</canvas>
        <button id="calibrate-stylus" type="button" data-calibrate-stylus>Send a three-pressure calibration</button>
        <p data-stylus-reply aria-live="polite">Stylus ready.</p>
      </div>
      <p id="stroke-count">{@stroke_count} strokes accepted</p>
      <p id="pressure-status" role="status">{@pressure_status}</p>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".PressureStylus">
        export default {
          mounted() {
            this.canvas = this.el.querySelector("canvas")
            this.canvas.style.width = "100%"
            this.canvas.style.height = "180px"
            this.listeners = new AbortController()
            const options = {signal: this.listeners.signal}
            this.resizeObserver = new ResizeObserver(([entry]) => {
              const ratio = window.devicePixelRatio || 1
              this.canvas.width = Math.max(1, Math.round(entry.contentRect.width * ratio))
              this.canvas.height = Math.round(180 * ratio)
              this.canvas.getContext("2d").setTransform(ratio, 0, 0, ratio, 0, 0)
            })
            this.resizeObserver.observe(this.canvas)
            this.canvas.addEventListener("pointerdown", pointer => {
              this.pressures = []
              this.activePointer = pointer.pointerId
              this.canvas.setPointerCapture(pointer.pointerId)
              this.samplePressure(pointer)
            }, options)
            this.canvas.addEventListener("pointermove", pointer => {
              if (this.activePointer === pointer.pointerId) this.samplePressure(pointer)
            }, options)
            this.canvas.addEventListener("pointerup", pointer => {
              if (this.activePointer !== pointer.pointerId) return
              this.activePointer = null
              this.sendStroke(this.pressures)
            }, options)
            this.canvas.addEventListener("pointercancel", () => { this.activePointer = null }, options)
            this.el.querySelector("[data-calibrate-stylus]").addEventListener("click", () => {
              this.sendStroke([25, 50, 75])
            }, options)
          },
          samplePressure(pointer) {
            const pressure = Math.round(pointer.pressure * 100)
            this.pressures.push(pressure)
            this.pressures = this.pressures.slice(-64)
            const bounds = this.canvas.getBoundingClientRect()
            const pen = this.canvas.getContext("2d")
            pen.fillStyle = "#1f3d2b"
            pen.beginPath()
            pen.arc(pointer.clientX - bounds.left, pointer.clientY - bounds.top, 1 + pressure / 20, 0, Math.PI * 2)
            pen.fill()
          },
          sendStroke(pressures) {
            this.pushEvent("record_stylus", {pressures}, reply => {
              this.el.querySelector("[data-stylus-reply]").textContent =
                reply.accepted ? `Mean ${reply.average}% · peak ${reply.peak}%` : reply.reason
            })
          },
          destroyed() {
            this.listeners.abort()
            this.resizeObserver.disconnect()
          }
        }
      </script>
    </Layouts.app>
    """
  end
end
