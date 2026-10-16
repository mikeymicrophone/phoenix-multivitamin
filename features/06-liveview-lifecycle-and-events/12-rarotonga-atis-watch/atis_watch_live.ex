# LiveView lifecycle and events · 12 · Rarotonga ATIS watch
#
# Teaches:
# - on_mount/1 runs before mount/3, on the static HTTP render and again on the connected mount
# - Those two invocations are different processes, so a booth counter sees two dons
# - attach_hook/4 from on_mount intercepts handle_event/3
# - {:halt, socket} skips the LiveView callback; {:cont, socket} lets it run

defmodule PhoenixMultivitaminWeb.RarotongaAtisWatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  on_mount {__MODULE__, :don_headset}

  alias PhoenixMultivitaminWeb.RarotongaAtisBooth

  def on_mount(:don_headset, _params, _session, socket) do
    RarotongaAtisBooth.record_don()

    socket =
      socket
      |> assign(:booth, "Rarotonga ATIS booth")
      |> assign(:tech, "Manu")
      |> assign(:headset_on?, true)
      |> attach_hook(:stamp_marks, :handle_event, &stamp_mark/3)

    {:cont, socket}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Rarotonga ATIS watch")
     |> assign(:connected_mount?, connected?(socket))
     |> assign(:calibrated?, false)
     |> assign(:marks, [])
     |> assign(:last_mark, nil)
     |> assign(:hook_then_mount, Map.has_key?(socket.assigns, :tech))}
  end

  @impl true
  def handle_event("mark_arrival", %{"flight" => flight}, socket) do
    {:noreply,
     socket
     |> assign(:last_mark, "A350 arrival")
     |> prepend_line("A350-900 flight #{flight} on the Rarotonga ATIS")}
  end

  def handle_event("mark_squall", _params, socket) do
    {:noreply,
     socket
     |> assign(:last_mark, "squall")
     |> prepend_line("Squall crossing the lagoon approach")}
  end

  def handle_event("calibrate_atis", _params, socket) do
    {:noreply, prepend_line(socket, "LiveView calibrate ran, which should not happen")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 12 · Rarotonga ATIS watch
      </p>

      <h1>Rarotonga ATIS watch</h1>
      <p class="lede">
        Booth tech {@tech} sits the ATIS booth at {@booth}. <code>on_mount</code>
        dons the headset before <code>mount/3</code>. A hook stamps marks and
        halts calibration so the LiveView callback never runs.
      </p>

      <p
        id="mount-banner"
        class={["mount-banner", if(@connected_mount?, do: "connected-mount", else: "static-mount")]}
      >
        <%= if @connected_mount? do %>
          Socket connected. The booth has already run on_mount for this process.
        <% else %>
          Static mount. on_mount still ran, in the HTTP request process.
        <% end %>
      </p>

      <dl class="station-meta">
        <dt>Booth</dt>
        <dd id="booth-name">{@booth}</dd>
        <dt>Tech</dt>
        <dd id="tech-name">{@tech}</dd>
        <dt>Headset</dt>
        <dd id="headset-state">{if @headset_on?, do: "on", else: "off"}</dd>
        <dt>Hook before mount</dt>
        <dd id="hook-then-mount">{if @hook_then_mount, do: "yes", else: "no"}</dd>
        <dt>Calibrated</dt>
        <dd id="calibrated-state">{if @calibrated?, do: "yes", else: "no"}</dd>
        <dt>Last mark</dt>
        <dd id="last-mark">{@last_mark || "none"}</dd>
      </dl>

      <div class="watch-actions">
        <button
          id="mark-arrival"
          type="button"
          phx-click="mark_arrival"
          phx-value-flight="ANZ84"
        >
          Mark ANZ84
        </button>
        <button id="mark-squall" type="button" phx-click="mark_squall">
          Mark squall
        </button>
        <button id="calibrate-atis" type="button" phx-click="calibrate_atis">
          Calibrate ATIS
        </button>
      </div>

      <div class="scenario">
        <h2>ATIS log</h2>
        <p :if={@marks == []} id="empty-log" class="muted">
          No marks this watch.
        </p>
        <ol id="marks" class="watch-log">
          <li :for={line <- @marks} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp stamp_mark("calibrate_atis", _params, socket) do
    RarotongaAtisBooth.record_hook("calibrate_atis")

    {:halt,
     socket
     |> assign(:calibrated?, true)
     |> prepend_line("ATIS calibrated in the on_mount hook; LiveView callback skipped")}
  end

  defp stamp_mark("mark_arrival", _params, socket) do
    RarotongaAtisBooth.record_hook("mark_arrival")
    {:cont, assign(socket, :last_mark, "pending A350 arrival")}
  end

  defp stamp_mark(_event, _params, socket) do
    {:cont, socket}
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :marks, [line | socket.assigns[:marks] || []])
  end
end
