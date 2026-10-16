# Client hooks · 11 · Kaohsiung Love River scope
#
# Teaches:
# - connected?/1 chooses a static fallback or a mounted hook, with no browser side effects in the HTTP render.
# - A mounted handshake registers handleEvent before requesting the first scope sweep.
# - Socket-assign pattern matching and a channel whitelist reject an unrecognized scope.

defmodule PhoenixMultivitaminWeb.KaohsiungLoveRiverScopeLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Kaohsiung Love River scope", "Chia-chen", "Bell 429")
     |> assign(connected_mount?: connected?(socket), scope_status: "Scope awaiting handshake")}
  end

  @impl true
  def handle_event(
        "arm_river_scope",
        %{"channel" => "river"},
        %{assigns: %{connected_mount?: true}} = socket
      ) do
    {:reply, %{armed: true},
     socket
     |> assign(:scope_status, "Love River training sweep armed")
     |> push_event("kaohsiung:sweep", %{bearings: [15, 45, 80], range_km: 6})}
  end

  def handle_event("arm_river_scope", _params, socket) do
    {:reply, %{armed: false, reason: "unknown_scope"}, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 11 · Kaohsiung Love River scope
      </p>

      <h1>Kaohsiung Love River scope</h1>
      <p class="lede">
        Rescue pilot {@clerk} arms the Love River training scope for the {@craft} only after the
        flight desk connects.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <%= if @connected_mount? do %>
        <div id="love-river-scope" phx-hook=".RiverScope" phx-update="ignore" class="scenario mt-6">
          <canvas width="360" height="180" class="max-w-full" role="img" aria-label="Love River training scope">
            River rescue training scope.
          </canvas>
          <p data-scope-reply aria-live="polite">Waiting for the scope handshake.</p>
        </div>
      <% else %>
        <p id="scope-static" class="mount-banner static-mount">Connect to arm the Love River scope.</p>
      <% end %>
      <p id="river-scope-status" role="status">{@scope_status}</p>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".RiverScope">
        export default {
          mounted() {
            this.sweepSubscription = this.handleEvent("kaohsiung:sweep", ({bearings, range_km}) => {
              const pen = this.el.querySelector("canvas").getContext("2d")
              pen.clearRect(0, 0, 360, 180)
              pen.fillStyle = "#1f3d2b"
              for (const bearing of bearings) {
                const radians = bearing * Math.PI / 180
                pen.beginPath()
                pen.arc(180 + 130 * Math.cos(radians), 170 - 130 * Math.sin(radians), 5, 0, Math.PI * 2)
                pen.fill()
              }
              this.el.querySelector("[data-scope-reply]").textContent = `${range_km} km training sweep`
            })
            this.pushEvent("arm_river_scope", {channel: "river"})
          },
          destroyed() { this.removeHandleEvent(this.sweepSubscription) }
        }
      </script>
    </Layouts.app>
    """
  end
end
