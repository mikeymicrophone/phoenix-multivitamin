# Client hooks · 13 · Kansai Izumisano aligner
#
# Teaches:
# - The capstone combines a mounted handshake, pushEvent replies, push_event/handleEvent, and listener cleanup.
# - An enforced-key struct owns sensor validation; its separate String.Chars implementation formats the stand report.
# - Socket destructuring guards a sequence number; with handles sensor failures without advancing it.

defmodule PhoenixMultivitaminWeb.KansaiIzumisanoAlignerLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.KansaiAlignment

  @impl true
  def mount(_params, _session, socket) do
    alignment = %KansaiAlignment{stand: "26", tolerance_mm: 4}

    {:ok,
     socket
     |> assign_scenario("Kansai Izumisano aligner", "Haruka", "Boeing 787-9")
     |> assign(alignment: alignment, sequence: 0, instrument_open?: true)}
  end

  @impl true
  def handle_event("read_alignment", _params, socket) do
    {:reply, alignment_snapshot(socket), socket}
  end

  def handle_event(
        "align_nosewheel",
        %{"sequence" => sequence, "sensors" => sensors},
        %{assigns: %{sequence: expected, instrument_open?: true}} = socket
      )
      when is_integer(sequence) and sequence == expected do
    with {:ok, alignment} <- KansaiAlignment.measure(socket.assigns.alignment, sensors) do
      socket = assign(socket, alignment: alignment, sequence: expected + 1)

      {:reply, %{accepted: true, sequence: expected + 1},
       push_event(socket, "kansai:alignment", alignment_snapshot(socket))}
    else
      {:error, reason} ->
        {:reply, %{accepted: false, reason: Atom.to_string(reason)}, socket}
    end
  end

  def handle_event("align_nosewheel", _params, socket) do
    {:reply, %{accepted: false, reason: "stale_or_closed_instrument"}, socket}
  end

  def handle_event("toggle_aligner", _params, socket) do
    {:noreply, update(socket, :instrument_open?, &(!&1))}
  end

  defp alignment_snapshot(socket) do
    %{
      sequence: socket.assigns.sequence,
      label: to_string(socket.assigns.alignment),
      aligned: KansaiAlignment.aligned?(socket.assigns.alignment)
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 13 · Kansai Izumisano aligner
      </p>

      <h1>Kansai Izumisano aligner</h1>
      <p class="lede">
        Docking engineer {@clerk} checks paired nosewheel sensors for the {@craft} at Kansai,
        rejecting stale measurements before the next alignment.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <p id="alignment-report">{to_string(@alignment)}</p>
      <p id="alignment-sequence">Measurement sequence {@sequence}</p>
      <button id="toggle-aligner" type="button" phx-click="toggle_aligner">
        {if(@instrument_open?, do: "Stow alignment instrument", else: "Deploy alignment instrument")}
      </button>
      <div :if={@instrument_open?} id="izumisano-aligner" phx-hook=".NosewheelAligner" phx-update="ignore"
        class="scenario mt-6">
        <div class="grid gap-4 sm:grid-cols-2">
          <.input id="left-wheel-sensor" type="number" name="left_wheel_mm" label="Left sensor (mm)"
            value={@alignment.left_mm} min="-40" max="40" step="1"
            class="block w-full rounded-lg border border-stone-400 bg-white px-3 py-2 text-stone-900 focus:border-green-800" />
          <.input id="right-wheel-sensor" type="number" name="right_wheel_mm" label="Right sensor (mm)"
            value={@alignment.right_mm} min="-40" max="40" step="1"
            class="block w-full rounded-lg border border-stone-400 bg-white px-3 py-2 text-stone-900 focus:border-green-800" />
        </div>
        <button id="measure-nosewheel" type="button" disabled data-measure-wheel>Measure wheel alignment</button>
        <p data-alignment-lamp role="status">Connecting alignment instrument.</p>
      </div>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".NosewheelAligner">
        export default {
          mounted() {
            this.instrumentPresent = true
            this.measureButton = this.el.querySelector("[data-measure-wheel]")
            this.alignmentSubscription = this.handleEvent("kansai:alignment", snapshot => this.paintAlignment(snapshot))
            this.requestAlignment()
            this.measureWheel = () => {
              this.measureButton.disabled = true
              const sensors = {
                left_mm: this.el.querySelector("#left-wheel-sensor").valueAsNumber,
                right_mm: this.el.querySelector("#right-wheel-sensor").valueAsNumber
              }
              this.pushEvent("align_nosewheel", {sequence: this.sequence, sensors}, reply => {
                if (!this.instrumentPresent) return
                this.measureButton.disabled = false
                if (!reply.accepted) {
                  this.el.querySelector("[data-alignment-lamp]").textContent = reply.reason
                  if (reply.reason === "stale_or_closed_instrument") this.requestAlignment()
                }
              })
            }
            this.measureButton.addEventListener("click", this.measureWheel)
          },
          requestAlignment() {
            this.pushEvent("read_alignment", {}, snapshot => {
              if (this.instrumentPresent) this.paintAlignment(snapshot)
            })
          },
          paintAlignment({sequence, label, aligned}) {
            this.sequence = sequence
            this.measureButton.disabled = false
            const lamp = this.el.querySelector("[data-alignment-lamp]")
            lamp.textContent = `${label} · ${aligned ? "Within tolerance" : "Check alignment"}`
            lamp.style.color = aligned ? "#1f3d2b" : "#b5651d"
          },
          destroyed() {
            this.instrumentPresent = false
            this.measureButton.removeEventListener("click", this.measureWheel)
            this.removeHandleEvent(this.alignmentSubscription)
          }
        }
      </script>
    </Layouts.app>
    """
  end
end
