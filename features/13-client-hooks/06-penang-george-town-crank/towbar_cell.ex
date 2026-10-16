# Client hooks · 06 · Penang towbar cell
#
# Teaches:
# - pushEventTo routes to this component's root, not its parent LiveView

defmodule PhoenixMultivitaminWeb.PenangTowbarCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @directions %{"tighten" => 1, "release" => -1}

  @impl true
  def mount(socket), do: {:ok, assign(socket, :turns, 0)}

  @impl true
  def handle_event("crank_towbar", %{"direction" => direction}, socket) do
    case Map.fetch(@directions, direction) do
      {:ok, step} ->
        turns = socket.assigns.turns + step

        cond do
          turns < 0 or turns > 6 ->
            {:reply, %{accepted: false, reason: "ratchet_stop"}, socket}

          true ->
            {:reply, %{accepted: true, turns: turns}, assign(socket, :turns, turns)}
        end

      :error ->
        {:reply, %{accepted: false, reason: "unknown_direction"}, socket}
    end
  end

  def handle_event("crank_towbar", _params, socket) do
    {:reply, %{accepted: false, reason: "unknown_direction"}, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section id={@id} class="scenario">
      <h2>{@tug}</h2>
      <p id={@id <> "-turns"}>{@turns} ratchet turns</p>
      <div id={@id <> "-hook"} phx-hook=".TowbarCrank" phx-update="ignore"
        phx-target={@myself} data-target={"#" <> @id}>
        <button id={@id <> "-tighten"} type="button" data-direction="tighten">Tighten</button>
        <button id={@id <> "-release"} type="button" data-direction="release">Release</button>
        <p data-ratchet-reply aria-live="polite">Ratchet ready.</p>
      </div>
      <script :type={Phoenix.LiveView.ColocatedHook} name=".TowbarCrank">
        export default {
          mounted() {
            this.crank = (press) => {
              const lever = press.target.closest("button[data-direction]")
              if (!lever || !this.el.contains(lever)) return
              this.pushEventTo(this.el.dataset.target, "crank_towbar",
                {direction: lever.dataset.direction}, (reply) => {
                  this.el.querySelector("[data-ratchet-reply]").textContent =
                    reply.accepted ? `${reply.turns} turns locked` : reply.reason
                })
            }
            this.el.addEventListener("click", this.crank)
          },
          destroyed() { this.el.removeEventListener("click", this.crank) }
        }
      </script>
    </section>
    """
  end
end
