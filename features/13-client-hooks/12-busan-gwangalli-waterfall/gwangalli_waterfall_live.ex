# Client hooks · 12 · Busan Gwangalli waterfall
#
# Teaches:
# - One colocated hook is reused by a function component with global attributes and a named slot with :let.
# - handleEvent receives a shared event name but filters by instrument ID before drawing.
# - A filter/sort/map pipeline converts frequency-strength tuples into a spectrum payload.

defmodule PhoenixMultivitaminWeb.BusanGwangalliWaterfallLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @spectra %{
    "air" => [{128, 10}, {118, 2}, {122, 8}, {125, 4}],
    "ground" => [{121, 5}, {123, 1}, {126, 9}]
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Busan Gwangalli waterfall", "Eun-ji", "H145")
     |> assign(:scan_status, "Training receivers ready")}
  end

  @impl true
  def handle_event("scan_gwangalli", %{"band" => band}, socket) do
    case Map.fetch(@spectra, band) do
      {:ok, channels} ->
        bins =
          channels
          |> Enum.filter(fn {_frequency, strength} -> strength >= 4 end)
          |> Enum.sort_by(&elem(&1, 0))
          |> Enum.map(fn {frequency, strength} -> %{mhz: frequency, strength: strength} end)

        peak = Enum.max_by(bins, & &1.strength)

        {:noreply,
         socket
         |> assign(:scan_status, "#{band}: #{length(bins)} audible training carriers")
         |> push_event("busan:spectrum", %{scope: band <> "-waterfall", bins: bins, peak_mhz: peak.mhz})}

      :error ->
        {:noreply, assign(socket, :scan_status, "Choose the air or ground receiver")}
    end
  end

  def handle_event("scan_gwangalli", _params, socket) do
    {:noreply, assign(socket, :scan_status, "Choose a training receiver")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 12 · Busan Gwangalli waterfall
      </p>

      <h1>Busan Gwangalli waterfall</h1>
      <p class="lede">
        Radio technician {@clerk} compares air and ground training spectra before the {@craft}
        departs for a Gwangalli rescue drill.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div class="mt-6 grid gap-4 sm:grid-cols-2">
        <.waterfall id="air-waterfall" band="air" data-station="Gwangalli air training">
          <:legend unit="MHz" :let={band}>{String.upcase(band)} rescue training</:legend>
        </.waterfall>
        <.waterfall id="ground-waterfall" band="ground" data-station="Gwangalli ground training">
          <:legend unit="MHz" :let={band}>{String.upcase(band)} crew training</:legend>
        </.waterfall>
      </div>
      <div class="watch-actions">
        <button id="scan-air" type="button" phx-click="scan_gwangalli" phx-value-band="air">Scan air receiver</button>
        <button id="scan-ground" type="button" phx-click="scan_gwangalli" phx-value-band="ground">Scan ground receiver</button>
      </div>
      <p id="scan-status" role="status">{@scan_status}</p>
    </Layouts.app>
    """
  end

  attr :id, :string, required: true
  attr :band, :string, required: true
  attr :rest, :global, default: %{class: "scenario"}

  slot :legend, required: true do
    attr :unit, :string, required: true
  end

  defp waterfall(assigns) do
    ~H"""
    <section id={@id} phx-hook=".Waterfall" phx-update="ignore" data-band={@band} {@rest}>
      <p :for={legend <- @legend} data-waterfall-legend>{render_slot(legend, @band)} · {legend.unit}</p>
      <canvas width="300" height="160" class="max-w-full" role="img" aria-label={@band <> " training spectrum"}>
        Training spectrum waterfall.
      </canvas>
      <p data-waterfall-peak aria-live="polite">No carrier scan yet.</p>
    </section>
    <script :type={Phoenix.LiveView.ColocatedHook} name=".Waterfall">
      export default {
        mounted() {
          this.spectrumSubscription = this.handleEvent("busan:spectrum", ({scope, bins, peak_mhz}) => {
            if (scope !== this.el.id) return
            const canvas = this.el.querySelector("canvas")
            const pen = canvas.getContext("2d")
            pen.drawImage(canvas, 0, 0, 300, 150, 0, 10, 300, 150)
            pen.clearRect(0, 0, 300, 10)
            bins.forEach(({strength}, index) => {
              pen.fillStyle = `rgba(31, 61, 43, ${strength / 10})`
              pen.fillRect(index * 300 / bins.length, 0, 300 / bins.length - 2, 10)
            })
            this.el.querySelector("[data-waterfall-peak]").textContent = `Peak ${peak_mhz} MHz`
          })
        },
        destroyed() { this.removeHandleEvent(this.spectrumSubscription) }
      }
    </script>
    """
  end
end
