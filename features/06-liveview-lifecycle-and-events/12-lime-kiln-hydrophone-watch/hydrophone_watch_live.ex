# LiveView lifecycle and events · 12 · Lime Kiln hydrophone watch
#
# Teaches:
# - on_mount/1 runs before mount/3, on the static HTTP render and again on the connected mount
# - Those two invocations are different processes, so a booth counter sees two dons
# - attach_hook/4 from on_mount intercepts handle_event/3
# - {:halt, socket} skips the LiveView callback; {:cont, socket} lets it run

defmodule PhoenixMultivitaminWeb.LimeKilnHydrophoneWatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  on_mount {__MODULE__, :don_headset}

  alias PhoenixMultivitaminWeb.LimeKilnHydrophoneBooth

  def on_mount(:don_headset, _params, _session, socket) do
    LimeKilnHydrophoneBooth.record_don()

    socket =
      socket
      |> assign(:booth, "Lime Kiln State Park hydrophone")
      |> assign(:listener, "Asta")
      |> assign(:headset_on?, true)
      |> attach_hook(:stamp_detections, :handle_event, &stamp_detection/3)

    {:cont, socket}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Lime Kiln hydrophone watch")
     |> assign(:connected_mount?, connected?(socket))
     |> assign(:calibrated?, false)
     |> assign(:detections, [])
     |> assign(:last_species, nil)
     |> assign(:hook_then_mount, Map.has_key?(socket.assigns, :listener))}
  end

  @impl true
  def handle_event("mark_orca", %{"pod" => pod}, socket) do
    {:noreply,
     socket
     |> assign(:last_species, "Southern Resident")
     |> prepend_line("Southern Resident pod #{pod} on the west-side hydrophone")}
  end

  def handle_event("mark_humpback", _params, socket) do
    {:noreply,
     socket
     |> assign(:last_species, "humpback")
     |> prepend_line("Humpback blowing off Deadman Bay")}
  end

  def handle_event("calibrate_array", _params, socket) do
    {:noreply, prepend_line(socket, "LiveView calibrate ran, which should not happen")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 12 · Lime Kiln hydrophone watch
      </p>

      <h1>Lime Kiln hydrophone watch</h1>
      <p class="lede">
        Listener {@listener} sits the hydrophone booth at {@booth}, on the
        west side of San Juan Island. <code>on_mount</code> dons the headset
        before <code>mount/3</code>. A hook stamps detections and halts
        calibration so the LiveView callback never runs.
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
        <dt>Listener</dt>
        <dd id="listener-name">{@listener}</dd>
        <dt>Headset</dt>
        <dd id="headset-state">{if @headset_on?, do: "on", else: "off"}</dd>
        <dt>Hook before mount</dt>
        <dd id="hook-then-mount">{if @hook_then_mount, do: "yes", else: "no"}</dd>
        <dt>Calibrated</dt>
        <dd id="calibrated-state">{if @calibrated?, do: "yes", else: "no"}</dd>
        <dt>Last species</dt>
        <dd id="last-species">{@last_species || "none"}</dd>
      </dl>

      <div class="watch-actions">
        <button
          id="mark-j-pod"
          type="button"
          phx-click="mark_orca"
          phx-value-pod="J"
        >
          Mark J pod
        </button>
        <button id="mark-humpback" type="button" phx-click="mark_humpback">
          Mark humpback
        </button>
        <button id="calibrate-array" type="button" phx-click="calibrate_array">
          Calibrate array
        </button>
      </div>

      <div class="scenario">
        <h2>Detection log</h2>
        <p :if={@detections == []} id="empty-log" class="muted">
          No detections this watch.
        </p>
        <ol id="detections" class="watch-log">
          <li :for={line <- @detections} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp stamp_detection("calibrate_array", _params, socket) do
    LimeKilnHydrophoneBooth.record_hook("calibrate_array")

    {:halt,
     socket
     |> assign(:calibrated?, true)
     |> prepend_line("Array calibrated in the on_mount hook; LiveView callback skipped")}
  end

  defp stamp_detection("mark_orca", _params, socket) do
    LimeKilnHydrophoneBooth.record_hook("mark_orca")
    {:cont, assign(socket, :last_species, "pending Southern Resident")}
  end

  defp stamp_detection(_event, _params, socket) do
    {:cont, socket}
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :detections, [line | socket.assigns[:detections] || []])
  end
end
