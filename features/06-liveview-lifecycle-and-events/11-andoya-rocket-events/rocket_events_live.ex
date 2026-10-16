# LiveView lifecycle and events · 11 · Andøya rocket events
#
# Teaches:
# - push_event/3 queues a client event that a colocated hook can handle
# - push_event during the disconnected render is discarded; only the connected mount delivers
# - {:reply, map, socket} from handle_event/3 answers a hook's pushEvent
# - assert_push_event/3 and assert_reply/2 are how LiveViewTest sees both

defmodule PhoenixMultivitaminWeb.AndoyaRocketEventsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Andøya rocket events")
      |> assign(:station, "Andøya Space")
      |> assign(:tech, "Eirik")
      |> assign(:apparatus, "ALV stack")
      |> assign(:connected_mount?, connected?(socket))
      |> assign(:stack_log, [])
      |> push_event("arm_stack", %{
        connected: connected?(socket),
        apparatus: "ALV stack"
      })

    {:ok, socket}
  end

  @impl true
  def handle_event("fire_stack", %{"blasts" => blasts}, socket) do
    {blasts, _} = Integer.parse(to_string(blasts))

    {:noreply,
     socket
     |> push_event("sound_stack", %{blasts: blasts, tone: "low motor"})
     |> prepend_line("Stack fired, #{blasts} pulses")}
  end

  def handle_event("stack_status", _params, socket) do
    {:reply,
     %{
       apparatus: socket.assigns.apparatus,
       tech: socket.assigns.tech,
       ready?: true
     }, prepend_line(socket, "Status asked from the stack console")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 11 · Andøya rocket events
      </p>

      <h1>Andøya rocket events</h1>
      <p class="lede">
        Range tech {@tech} arms the {@apparatus} at {@station}. The server
        pushes <code>arm_stack</code> and <code>sound_stack</code> to a colocated hook.
      </p>

      <p
        id="mount-banner"
        class={["mount-banner", if(@connected_mount?, do: "connected-mount", else: "static-mount")]}
      >
        <%= if @connected_mount? do %>
          Socket connected. The stack is armed with a push_event.
        <% else %>
          Static mount. push_event has nowhere to go until the socket connects.
        <% end %>
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Tech</dt>
        <dd id="tech-name">{@tech}</dd>
        <dt>Apparatus</dt>
        <dd id="apparatus-name">{@apparatus}</dd>
      </dl>

      <div
        id="stack-console"
        phx-hook=".StackConsole"
        phx-update="ignore"
        data-last-push="none"
      >
        Last push: <span id="last-push">none</span>
      </div>

      <div class="watch-actions">
        <button
          id="two-blasts"
          type="button"
          phx-click="fire_stack"
          phx-value-blasts="2"
        >
          Two pulses
        </button>
        <button
          id="one-blast"
          type="button"
          phx-click="fire_stack"
          phx-value-blasts="1"
        >
          One pulse
        </button>
      </div>

      <div class="scenario">
        <h2>Stack log</h2>
        <p :if={@stack_log == []} id="empty-log" class="muted">
          No pulses this watch.
        </p>
        <ol id="stack-log" class="watch-log">
          <li :for={line <- @stack_log} id={line.id}>{line.body}</li>
        </ol>
      </div>

      <script :type={Phoenix.LiveView.ColocatedHook} name=".StackConsole">
        export default {
          mounted() {
            this.handleEvent("arm_stack", (payload) => {
              this.el.dataset.lastPush = "arm_stack"
              this.el.querySelector("#last-push").textContent =
                payload.connected ? "armed connected" : "armed static"
            })
            this.handleEvent("sound_stack", (payload) => {
              this.el.dataset.lastPush = "sound_stack"
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
    assign(socket, :stack_log, [line | socket.assigns.stack_log])
  end
end
