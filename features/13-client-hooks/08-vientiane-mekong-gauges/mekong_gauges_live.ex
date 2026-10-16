# Client hooks · 08 · Vientiane Mekong gauges
#
# Teaches:
# - disconnected() marks stale gauges; reconnected() requests an authoritative snapshot.
# - A mounted handshake avoids relying on an event sent before the hook is listening.
# - Enum.reduce/3 turns station tuples into the same reply and push-event payload.

defmodule PhoenixMultivitaminWeb.VientianeMekongGaugesLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Vientiane Mekong gauges", "Khamla", "Lao Airlines ATR 72")
     |> assign(revision: 1, pressure_hpa: 1008, rain_mm: 6)}
  end

  @impl true
  def handle_event("resume_gauges", %{"revision" => revision}, socket)
      when is_integer(revision) and revision >= 0 do
    {:reply, gauge_snapshot(socket), socket}
  end

  def handle_event("resume_gauges", _params, socket) do
    {:reply, %{accepted: false, reason: "invalid_revision"}, socket}
  end

  def handle_event("post_monsoon", _params, socket) do
    socket =
      socket
      |> update(:revision, &(&1 + 1))
      |> assign(pressure_hpa: 1004, rain_mm: 18)

    {:noreply, push_event(socket, "vientiane:gauges", gauge_snapshot(socket))}
  end

  defp gauge_snapshot(socket) do
    readings =
      Enum.reduce(
        [{"pressure_hpa", socket.assigns.pressure_hpa}, {"rain_mm", socket.assigns.rain_mm}],
        %{},
        fn {instrument, reading}, snapshot -> Map.put(snapshot, instrument, reading) end
      )

    %{accepted: true, revision: socket.assigns.revision, readings: readings}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 08 · Vientiane Mekong gauges
      </p>

      <h1>Vientiane Mekong gauges</h1>
      <p class="lede">
        Weather observer {@clerk} refreshes Wattay pressure and rain gauges for the {@craft}
        after a socket interruption.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div id="mekong-gauges" phx-hook=".MekongGauges" phx-update="ignore" class="scenario mt-6">
        <p data-link-state role="status">Waiting for gauge connection.</p>
        <p data-gauge-readings>No instrument snapshot yet.</p>
      </div>
      <p id="gauge-revision">Station revision {@revision}</p>
      <button id="post-monsoon" type="button" phx-click="post_monsoon">Post monsoon readings</button>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".MekongGauges">
        export default {
          mounted() {
            this.revision = 0
            this.gaugeSubscription = this.handleEvent("vientiane:gauges", snapshot => this.paintGauges(snapshot))
            this.requestSnapshot()
          },
          disconnected() {
            this.el.querySelector("[data-link-state]").textContent = "Connection lost · readings stale"
          },
          reconnected() { this.requestSnapshot() },
          requestSnapshot() {
            this.pushEvent("resume_gauges", {revision: this.revision}, snapshot => this.paintGauges(snapshot))
          },
          paintGauges({accepted, revision, readings}) {
            if (!accepted) return
            this.revision = revision
            this.el.querySelector("[data-link-state]").textContent = `Connected · revision ${revision}`
            this.el.querySelector("[data-gauge-readings]").textContent =
              `${readings.pressure_hpa} hPa · ${readings.rain_mm} mm rain`
          },
          destroyed() { this.removeHandleEvent(this.gaugeSubscription) }
        }
      </script>
    </Layouts.app>
    """
  end
end
