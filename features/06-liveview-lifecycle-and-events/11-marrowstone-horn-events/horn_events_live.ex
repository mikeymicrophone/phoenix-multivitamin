# LiveView lifecycle and events · 11 · Marrowstone horn events
#
# Teaches:
# - push_event/3 queues a client event that a colocated hook can handle
# - push_event during the disconnected render is discarded; only the connected mount delivers
# - {:reply, map, socket} from handle_event/3 answers a hook's pushEvent
# - assert_push_event/3 and assert_reply/2 are how LiveViewTest sees both

defmodule PhoenixMultivitaminWeb.MarrowstoneHornEventsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Marrowstone horn events")
      |> assign(:station, "Marrowstone Point Light")
      |> assign(:keeper, "Linus")
      |> assign(:apparatus, "Type F diaphone")
      |> assign(:connected_mount?, connected?(socket))
      |> assign(:horn_log, [])
      |> push_event("arm_horn", %{
        connected: connected?(socket),
        apparatus: "Type F diaphone"
      })

    {:ok, socket}
  end

  @impl true
  def handle_event("sound_diaphone", %{"blasts" => blasts}, socket) do
    {blasts, _} = Integer.parse(to_string(blasts))

    {:noreply,
     socket
     |> push_event("sound_horn", %{blasts: blasts, tone: "low diaphone"})
     |> prepend_line("Diaphone sounded, #{blasts} blasts")}
  end

  def handle_event("horn_status", _params, socket) do
    {:reply,
     %{
       apparatus: socket.assigns.apparatus,
       keeper: socket.assigns.keeper,
       ready?: true
     }, prepend_line(socket, "Status asked from the horn console")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 11 · Marrowstone horn events
      </p>

      <h1>Marrowstone horn events</h1>
      <p class="lede">
        Keeper {@keeper} sounds the {@apparatus} at {@station}, on the
        Admiralty Inlet shore of Marrowstone Island. The server pushes <code>arm_horn</code>
        and <code>sound_horn</code>
        to a colocated hook.
      </p>

      <p
        id="mount-banner"
        class={["mount-banner", if(@connected_mount?, do: "connected-mount", else: "static-mount")]}
      >
        <%= if @connected_mount? do %>
          Socket connected. The diaphone is armed with a push_event.
        <% else %>
          Static mount. push_event has nowhere to go until the socket connects.
        <% end %>
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Apparatus</dt>
        <dd id="apparatus-name">{@apparatus}</dd>
      </dl>

      <div
        id="horn-console"
        phx-hook=".HornConsole"
        phx-update="ignore"
        data-last-push="none"
      >
        Last push: <span id="last-push">none</span>
      </div>

      <div class="watch-actions">
        <button
          id="two-blasts"
          type="button"
          phx-click="sound_diaphone"
          phx-value-blasts="2"
        >
          Two blasts
        </button>
        <button
          id="one-blast"
          type="button"
          phx-click="sound_diaphone"
          phx-value-blasts="1"
        >
          One blast
        </button>
      </div>

      <div class="scenario">
        <h2>Horn log</h2>
        <p :if={@horn_log == []} id="empty-log" class="muted">
          No blasts this watch.
        </p>
        <ol id="horn-log" class="watch-log">
          <li :for={line <- @horn_log} id={line.id}>{line.body}</li>
        </ol>
      </div>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".HornConsole">
        export default {
          mounted() {
            this.handleEvent("arm_horn", (payload) => {
              this.el.dataset.lastPush = "arm_horn"
              this.el.querySelector("#last-push").textContent =
                payload.connected ? "armed connected" : "armed static"
            })
            this.handleEvent("sound_horn", (payload) => {
              this.el.dataset.lastPush = "sound_horn"
              this.el.querySelector("#last-push").textContent =
                `${payload.blasts} ${payload.tone}`
            })
          }
        }
      </script>
    </Layouts.catalog>
    """
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :horn_log, [line | socket.assigns.horn_log])
  end
end
