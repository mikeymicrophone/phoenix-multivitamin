# Client hooks · 03 · Denpasar Nusa chime hook
#
# Teaches:
# - JS.dispatch/2 reaches a window listener that is removed by destroyed().
# - Conditional hook removal and remounting avoid accumulating global listeners.
# - Numeric hook payloads match guarded function heads instead of phx-value strings.

defmodule PhoenixMultivitaminWeb.DenpasarNusaChimeHookLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Denpasar Nusa chime hook", "Ayu", "DHC-6 Twin Otter")
     |> assign(bell_present?: true, chime_count: 0, chime_status: "Bell ready")}
  end

  @impl true
  def handle_event("pack_bell", _params, socket) do
    {:noreply, update(socket, :bell_present?, &(!&1))}
  end

  def handle_event("hear_boarding_chime", %{"strikes" => strikes},
        %{assigns: %{bell_present?: true}} = socket)
      when is_integer(strikes) and strikes in 1..3 do
    {:noreply,
     socket
     |> update(:chime_count, &(&1 + strikes))
     |> assign(:chime_status, "Nusa Penida boarding call heard")}
  end

  def handle_event("hear_boarding_chime", _params, socket) do
    {:noreply, assign(socket, :chime_status, "Unpack the bell and use one to three strikes")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Client hooks · 03 · Denpasar Nusa chime hook
      </p>

      <h1>Denpasar Nusa chime hook</h1>
      <p class="lede">
        Gate agent {@clerk} rehearses a Nusa Penida boarding chime for the {@craft}, then packs
        the bell away.
      </p>
      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div class="watch-actions">
        <button id="ring-nusa" type="button" disabled={!@bell_present?}
          phx-click={JS.dispatch("denpasar:boarding-chime", detail: %{strikes: 2})}>
          Rehearse two strikes
        </button>
        <button id="pack-bell" type="button" phx-click="pack_bell">
          {if(@bell_present?, do: "Pack the bell", else: "Unpack the bell")}
        </button>
      </div>
      <div :if={@bell_present?} id="nusa-bell" phx-hook=".BoardingChime" phx-update="ignore"
        class="scenario" aria-live="polite">
        <p data-chime-caption>Waiting for a boarding call.</p>
      </div>
      <p id="chime-count">{@chime_count} strikes heard</p>
      <p id="chime-status" role="status">{@chime_status}</p>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".BoardingChime">
        export default {
          mounted() {
            this.hearBoarding = ({detail: {strikes}}) => {
              this.el.querySelector("[data-chime-caption]").textContent = `${strikes} boarding strikes`
              this.pushEvent("hear_boarding_chime", {strikes})
            }
            window.addEventListener("denpasar:boarding-chime", this.hearBoarding)
          },
          destroyed() {
            window.removeEventListener("denpasar:boarding-chime", this.hearBoarding)
          }
        }
      </script>
    </Layouts.app>
    """
  end
end
