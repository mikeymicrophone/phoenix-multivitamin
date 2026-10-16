# Client hooks · 09 · Luang Prabang Pak Ou knobs
#
# Teaches:
# - Stream rows have stable custom DOM IDs and individual ignored hook roots.
# - stream_insert updates a row dataset; stream_delete_by_dom_id removes it and destroys its hook.
# - Map.fetch and Map.pop reject missing aircraft without recreating a removed row.

defmodule PhoenixMultivitaminWeb.LuangPrabangPakOuKnobsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    aircraft = Map.new([{"rdpl-341", 1500}, {"rdpl-342", 1600}], fn {registration, rpm} ->
      {registration, %{id: registration, rpm: rpm}}
    end)

    {:ok,
     socket
     |> assign_scenario("Luang Prabang Pak Ou knobs", "Mali", "Cessna 208 Caravan")
     |> assign(aircraft: aircraft, propeller_status: "Inspection knobs ready")
     |> stream_configure(:propellers, dom_id: &"propeller-#{&1.id}")
     |> stream(:propellers, aircraft |> Map.values() |> Enum.sort_by(& &1.id))}
  end

  @impl true
  def handle_event("set_propeller", %{"aircraft" => registration, "rpm" => rpm}, socket)
      when is_integer(rpm) and rpm >= 1000 and rpm <= 1900 do
    case Map.fetch(socket.assigns.aircraft, registration) do
      {:ok, propeller} ->
        propeller = %{propeller | rpm: rpm}

        {:noreply,
         socket
         |> update(:aircraft, &Map.put(&1, registration, propeller))
         |> stream_insert(:propellers, propeller, update_only: true)
         |> assign(:propeller_status, "#{registration} inspection speed accepted")}

      :error ->
        {:noreply, assign(socket, :propeller_status, "Aircraft has left the inspection rack")}
    end
  end

  def handle_event("set_propeller", _params, socket) do
    {:noreply, assign(socket, :propeller_status, "Inspection speed must be 1000 to 1900 RPM")}
  end

  def handle_event("park_aircraft", %{"aircraft" => registration}, socket) do
    case Map.pop(socket.assigns.aircraft, registration) do
      {nil, _aircraft} ->
        {:noreply, assign(socket, :propeller_status, "Aircraft is already parked")}

      {_propeller, aircraft} ->
        {:noreply,
         socket
         |> assign(aircraft: aircraft, propeller_status: "#{registration} parked")
         |> stream_delete_by_dom_id(:propellers, "propeller-#{registration}")}
    end
  end

  def handle_event("park_aircraft", _params, socket) do
    {:noreply, assign(socket, :propeller_status, "Choose an aircraft to park")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 09 · Luang Prabang Pak Ou knobs
      </p>

      <h1>Luang Prabang Pak Ou knobs</h1>
      <p class="lede">
        Engineer {@clerk} adjusts propeller inspection knobs for two {@craft} crews returning
        from the Pak Ou supply run.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div id="propeller-rack" phx-update="stream" class="mt-6 grid gap-4">
        <p id="empty-rack" class="hidden only:block">All aircraft parked.</p>
        <div :for={{dom_id, propeller} <- @streams.propellers} id={dom_id}
          phx-hook=".PropellerKnob" phx-update="ignore" data-aircraft={propeller.id}
          data-rpm={propeller.rpm} class="scenario">
          <h2>{propeller.id}</h2>
          <p data-rpm-caption>{propeller.rpm} RPM</p>
          <button id={"advance-" <> propeller.id} type="button" data-advance-rpm>Advance 100 RPM</button>
          <button id={"park-" <> propeller.id} type="button" phx-click="park_aircraft"
            phx-value-aircraft={propeller.id}>Park aircraft</button>
        </div>
      </div>
      <p id="propeller-status" role="status">{@propeller_status}</p>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".PropellerKnob">
        export default {
          mounted() {
            this.advanceButton = this.el.querySelector("[data-advance-rpm]")
            this.advancePropeller = () => this.pushEvent("set_propeller", {
              aircraft: this.el.dataset.aircraft, rpm: Number(this.el.dataset.rpm) + 100
            })
            this.advanceButton.addEventListener("click", this.advancePropeller)
            this.paintRpm()
          },
          updated() { this.paintRpm() },
          paintRpm() {
            this.el.querySelector("[data-rpm-caption]").textContent = `${this.el.dataset.rpm} RPM`
          },
          destroyed() { this.advanceButton.removeEventListener("click", this.advancePropeller) }
        }
      </script>
    </Layouts.app>
    """
  end
end
