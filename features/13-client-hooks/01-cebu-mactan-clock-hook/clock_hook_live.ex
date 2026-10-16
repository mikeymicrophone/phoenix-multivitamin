# Client hooks · 01 · Cebu Mactan clock hook
#
# Teaches:
# - mounted() formats two clocks with Intl.DateTimeFormat and dataset time zones.
# - destroyed() clears the browser interval; static HTML remains useful before connection.

defmodule PhoenixMultivitaminWeb.CebuMactanClockHookLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Cebu Mactan clock hook", "Luningning", "ATR 72-600")
     |> assign(:dispatch_zone, "Asia/Manila")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 01 · Cebu Mactan clock hook
      </p>

      <h1>Cebu Mactan clock hook</h1>
      <p class="lede">
        Dispatcher {@clerk} compares the Mactan departure clock with UTC before releasing the
        {@craft}.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div class="scenario mt-6 grid gap-4 sm:grid-cols-2">
        <div id="mactan-clock" phx-hook=".DispatchClock" phx-update="ignore" data-zone={@dispatch_zone}>
          <h2>Mactan departure desk</h2>
          <time>Clock starts when the departure desk connects.</time>
        </div>
        <div id="utc-clock" phx-hook=".DispatchClock" phx-update="ignore" data-zone="UTC">
          <h2>Flight-plan reference</h2>
          <time>UTC clock starts on connection.</time>
        </div>
      </div>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".DispatchClock">
        export default {
          mounted() {
            const formatter = new Intl.DateTimeFormat("en-GB", {
              timeZone: this.el.dataset.zone, hour: "2-digit", minute: "2-digit", second: "2-digit"
            })
            const clock = this.el.querySelector("time")
            const tick = () => {
              const instant = new Date()
              clock.dateTime = instant.toISOString()
              clock.textContent = formatter.format(instant)
            }
            tick()
            this.clockInterval = window.setInterval(tick, 1000)
          },
          destroyed() {
            window.clearInterval(this.clockInterval)
          }
        }
      </script>
    </Layouts.app>
    """
  end
end
