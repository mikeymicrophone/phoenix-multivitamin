# Client hooks · 04 · Yogyakarta Borobudur canvas
#
# Teaches:
# - Pointer coordinates become a nested pushEvent payload; the reply paints the accepted tow point.
# - with validates integer metres and a tow lane boundary, with explicit rejection replies.

defmodule PhoenixMultivitaminWeb.YogyakartaBorobudurCanvasLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Yogyakarta Borobudur canvas", "Sekar", "Airbus A320")
     |> assign(tow_metres: 0, tow_status: "Choose a rendezvous")}
  end

  @impl true
  def handle_event("mark_tow_point", %{"position" => %{"metres" => metres}}, socket) do
    with true <- is_integer(metres),
         true <- metres in 0..1000 do
      {:reply, %{accepted: true, metres: metres},
       assign(socket, tow_metres: metres, tow_status: "Tow rendezvous accepted")}
    else
      false ->
        {:reply, %{accepted: false, reason: "outside_tow_lane"},
         assign(socket, :tow_status, "Choose whole metres within the 1000 m tow lane")}
    end
  end

  def handle_event("mark_tow_point", _params, socket) do
    {:reply, %{accepted: false, reason: "missing_position"}, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 04 · Yogyakarta Borobudur canvas
      </p>

      <h1>Yogyakarta Borobudur canvas</h1>
      <p class="lede">
        Tow planner {@clerk} marks a rendezvous along the {@craft} tow lane before the Borobudur
        charter departs.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div id="borobudur-lane" phx-hook=".TowCanvas" phx-update="ignore" class="scenario mt-6">
        <canvas width="600" height="100" class="max-w-full cursor-crosshair" role="img"
          aria-label="Tow rendezvous along a 1000 metre lane">
          Use the midpoint button if canvas is unavailable.
        </canvas>
        <button id="tow-midpoint" type="button" data-tow-midpoint>Choose the 500 m midpoint</button>
        <p data-tow-reply aria-live="polite">No tow point sent.</p>
      </div>
      <p id="tow-metres">{@tow_metres} m</p>
      <p id="tow-status" role="status">{@tow_status}</p>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".TowCanvas">
        export default {
          mounted() {
            this.canvas = this.el.querySelector("canvas")
            this.midpoint = this.el.querySelector("[data-tow-midpoint]")
            this.markPointer = (pointer) => {
              const bounds = this.canvas.getBoundingClientRect()
              if (bounds.width <= 0) return
              this.sendTowPoint(Math.round((pointer.clientX - bounds.left) / bounds.width * 1000))
            }
            this.markMidpoint = () => this.sendTowPoint(500)
            this.canvas.addEventListener("pointerdown", this.markPointer)
            this.midpoint.addEventListener("click", this.markMidpoint)
            this.paintTowPoint(0)
          },
          sendTowPoint(metres) {
            this.pushEvent("mark_tow_point", {position: {metres}}, (reply) => {
              this.el.querySelector("[data-tow-reply]").textContent =
                reply.accepted ? `Rendezvous: ${reply.metres} m` : "Tow lane boundary exceeded"
              if (reply.accepted) this.paintTowPoint(reply.metres)
            })
          },
          paintTowPoint(metres) {
            const pen = this.canvas.getContext("2d")
            pen.clearRect(0, 0, 600, 100)
            pen.fillStyle = "#e4dccb"
            pen.fillRect(0, 40, 600, 20)
            pen.fillStyle = "#1f3d2b"
            pen.fillRect(metres * 0.6 - 3, 20, 6, 60)
          },
          destroyed() {
            this.canvas.removeEventListener("pointerdown", this.markPointer)
            this.midpoint.removeEventListener("click", this.markMidpoint)
          }
        }
      </script>
    </Layouts.app>
    """
  end
end
