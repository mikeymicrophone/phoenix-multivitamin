# Client hooks · 07 · Langkawi cable bells
#
# Teaches:
# - Dataset attributes carry a tuple-derived bell program into mounted() and updated().
# - A changed cadence restarts a browser interval; destroyed() clears it.
# - Tuple matching and a guarded program lookup keep unlisted cadences off the instrument.

defmodule PhoenixMultivitaminWeb.LangkawiCableBellsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @bell_programs %{"ridge" => {1200, "Ridge rescue"}, "shore" => {2400, "Shore standby"}}

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Langkawi cable bells", "Suri", "AW139")
     |> assign(cadence_ms: 2400, bell_label: "Shore standby", bell_status: "Program ready")}
  end

  @impl true
  def handle_event("set_bell_program", %{"program" => program}, socket)
      when is_map_key(@bell_programs, program) do
    {cadence, label} = Map.fetch!(@bell_programs, program)
    {:noreply, assign(socket, cadence_ms: cadence, bell_label: label, bell_status: "Program loaded")}
  end

  def handle_event("set_bell_program", _params, socket) do
    {:noreply, assign(socket, :bell_status, "Choose ridge or shore")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 07 · Langkawi cable bells
      </p>

      <h1>Langkawi cable bells</h1>
      <p class="lede">
        Helicopter coordinator {@clerk} sets the cable-car rescue bell cadence before the
        {@craft} lifts toward the ridge.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div id="cable-bell" phx-hook=".CableBell" phx-update="ignore" data-cadence-ms={@cadence_ms}
        data-bell-label={@bell_label} class="scenario mt-6">
        <p data-bell-pulse aria-live="off">Shore standby</p>
      </div>
      <p id="bell-program-status" role="status">{@bell_status}</p>
      <div class="watch-actions">
        <button id="ridge-program" type="button" phx-click="set_bell_program" phx-value-program="ridge">
          Ridge rescue cadence
        </button>
        <button id="shore-program" type="button" phx-click="set_bell_program" phx-value-program="shore">
          Shore standby cadence
        </button>
      </div>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".CableBell">
        export default {
          mounted() { this.loadCadence() },
          updated() { this.loadCadence() },
          loadCadence() {
            window.clearInterval(this.bellInterval)
            const {cadenceMs, bellLabel} = this.el.dataset
            const caption = this.el.querySelector("[data-bell-pulse]")
            caption.textContent = bellLabel
            this.bellInterval = window.setInterval(() => {
              caption.textContent = `${bellLabel} · ${new Date().toLocaleTimeString("en-GB")}`
            }, Number(cadenceMs))
          },
          destroyed() { window.clearInterval(this.bellInterval) }
        }
      </script>
    </Layouts.app>
    """
  end
end
