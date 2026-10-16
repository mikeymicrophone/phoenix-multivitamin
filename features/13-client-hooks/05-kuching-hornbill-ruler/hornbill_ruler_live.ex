# Client hooks · 05 · Kuching hornbill ruler
#
# Teaches:
# - push_event/3 delivers a ruler scale to handleEvent; its subscription is removed on destruction.
# - Map.fetch/2 selects a fleet span; a filtered comprehension builds metre ticks.

defmodule PhoenixMultivitaminWeb.KuchingHornbillRulerLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @fleet_spans %{"dornier" => 17, "twin_otter" => 20}

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Kuching hornbill ruler", "Dayang", "Dornier 228")
     |> assign(:ruler_status, "Choose the hangar visitor")}
  end

  @impl true
  def handle_event("calibrate_span", %{"fleet" => fleet}, socket) do
    case Map.fetch(@fleet_spans, fleet) do
      {:ok, span} ->
        ticks = for metre <- 0..span, rem(metre, 2) == 0, do: metre

        {:noreply,
         socket
         |> assign(:ruler_status, "Clearance ruler calibrated to #{span} m")
         |> push_event("kuching:ruler", %{span: span, ticks: ticks})}

      :error ->
        {:noreply, assign(socket, :ruler_status, "No wing span recorded for that fleet")}
    end
  end

  def handle_event("calibrate_span", _params, socket) do
    {:noreply, assign(socket, :ruler_status, "Choose a recorded fleet")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 05 · Kuching hornbill ruler
      </p>

      <h1>Kuching hornbill ruler</h1>
      <p class="lede">
        Loadmaster {@clerk} calibrates a wing-clearance ruler before the {@craft} enters the
        Kuching hangar.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div class="watch-actions">
        <button id="measure-dornier" type="button" phx-click="calibrate_span" phx-value-fleet="dornier">
          Dornier span
        </button>
        <button id="measure-otter" type="button" phx-click="calibrate_span" phx-value-fleet="twin_otter">
          Twin Otter span
        </button>
      </div>
      <div id="hornbill-ruler" phx-hook=".WingRuler" phx-update="ignore" class="scenario">
        <canvas width="600" height="100" class="max-w-full" role="img" aria-label="Wing clearance metre scale">
          Wing clearance ruler.
        </canvas>
        <p data-ruler-caption>Awaiting a fleet calibration.</p>
      </div>
      <p id="ruler-status" role="status">{@ruler_status}</p>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".WingRuler">
        export default {
          mounted() {
            this.rulerSubscription = this.handleEvent("kuching:ruler", ({span, ticks}) => {
              const canvas = this.el.querySelector("canvas")
              const pen = canvas.getContext("2d")
              pen.clearRect(0, 0, canvas.width, canvas.height)
              pen.fillStyle = "#1f3d2b"
              for (const metre of ticks) {
                const mark = 15 + metre / span * 560
                pen.fillRect(mark, 20, 2, 35)
                pen.fillText(`${metre} m`, mark - 10, 75)
              }
              this.el.querySelector("[data-ruler-caption]").textContent = `${span} m wing span`
            })
          },
          destroyed() { this.removeHandleEvent(this.rulerSubscription) }
        }
      </script>
    </Layouts.app>
    """
  end
end
