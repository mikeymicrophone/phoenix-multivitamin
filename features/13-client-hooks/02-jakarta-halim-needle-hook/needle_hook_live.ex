# Client hooks · 02 · Jakarta Halim needle hook
#
# Teaches:
# - beforeUpdate() snapshots the old bearing synchronously; updated() reads merged data attributes.
# - Integer.parse/1 and guarded result clauses reject partial or out-of-range bearings.

defmodule PhoenixMultivitaminWeb.JakartaHalimNeedleHookLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Jakarta Halim needle hook", "Ratih", "CN-235")
     |> assign(bearing: 60, bearing_status: "Stand heading set")}
  end

  @impl true
  def handle_event("turn_needle", %{"bearing" => bearing}, socket) when is_binary(bearing) do
    case Integer.parse(bearing) do
      {degrees, ""} when degrees >= 0 and degrees < 360 ->
        {:noreply, assign(socket, bearing: degrees, bearing_status: "Heading accepted")}

      _rejected ->
        {:noreply, assign(socket, :bearing_status, "Use a whole bearing from 0 to 359")}
    end
  end

  def handle_event("turn_needle", _params, socket) do
    {:noreply, assign(socket, :bearing_status, "Bearing must arrive as text")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 02 · Jakarta Halim needle hook
      </p>

      <h1>Jakarta Halim needle hook</h1>
      <p class="lede">
        Marshaller {@clerk} turns the {@craft} heading needle while the hook keeps its canvas
        between patches.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div class="scenario mt-6">
        <div id="halim-needle" phx-hook=".HeadingNeedle" phx-update="ignore" data-bearing={@bearing}>
          <canvas width="240" height="160" role="img" aria-label="Aircraft heading needle">
            Heading needle requires canvas support.
          </canvas>
          <p data-bearing-change>Initial heading.</p>
        </div>
        <p id="bearing-readout">{@bearing}°</p>
        <p id="bearing-status" role="status">{@bearing_status}</p>
        <button id="face-apron" type="button" phx-click="turn_needle" phx-value-bearing="120">
          Face the east apron
        </button>
      </div>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".HeadingNeedle">
        export default {
          mounted() { this.drawNeedle() },
          beforeUpdate() { this.previousBearing = this.el.dataset.bearing },
          updated() {
            this.drawNeedle()
            this.el.querySelector("[data-bearing-change]").textContent =
              `${this.previousBearing}° → ${this.el.dataset.bearing}°`
          },
          drawNeedle() {
            const canvas = this.el.querySelector("canvas")
            const pen = canvas.getContext("2d")
            const radians = (Number(this.el.dataset.bearing) - 90) * Math.PI / 180
            pen.clearRect(0, 0, canvas.width, canvas.height)
            pen.beginPath()
            pen.moveTo(120, 80)
            pen.lineTo(120 + 65 * Math.cos(radians), 80 + 65 * Math.sin(radians))
            pen.strokeStyle = "#1f3d2b"
            pen.lineWidth = 6
            pen.stroke()
          }
        }
      </script>
    </Layouts.app>
    """
  end
end
