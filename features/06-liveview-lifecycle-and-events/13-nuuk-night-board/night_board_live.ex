# LiveView lifecycle and events · 13 · Nuuk night board
#
# Teaches:
# - Capstone: mount, handle_params, handle_event, handle_info, and terminate together
# - The disconnected HTTP render does not spawn a LiveView process, so terminate/2 does not run
# - terminate/2 does run when the connected LiveView process stops
# - handle_params/3 switches the watch without remounting; events and the clock keep their assigns

defmodule PhoenixMultivitaminWeb.NuukNightBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.NuukDepartureDesk

  @watches %{
    "first" => %{
      name: "First watch",
      window: "20:00–24:00",
      controller: "Naja",
      clock: ~T[20:00:00]
    },
    "mid" => %{
      name: "Midwatch",
      window: "00:00–04:00",
      controller: "Malik",
      clock: ~T[00:00:00]
    }
  }

  @impl true
  def mount(_params, _session, socket) do
    connected_mount? = connected?(socket)

    socket =
      socket
      |> assign(:page_title, "Nuuk night board")
      |> assign(:station, "Nuuk Airport")
      |> assign(:connected_mount?, connected_mount?)
      |> assign(:traffic_lines, [])
      |> assign(:tick_count, 0)
      |> assign(:clock_armed?, connected_mount?)

    socket =
      if connected_mount? do
        send(self(), :board_tick)
        socket
      else
        socket
      end

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    watch_key = Map.get(params, "watch", "first")
    watch = Map.get(@watches, watch_key, @watches["first"])

    {:noreply,
     socket
     |> assign(:watch_key, watch_key)
     |> assign(:watch, watch)
     |> assign(:station_clock, watch.clock)}
  end

  @impl true
  def handle_event("log_inbound_flight", %{"flight" => flight}, socket) do
    {:noreply,
     prepend_line(
       socket,
       "#{flight} inbound, descending the fjord onto 05"
     )}
  end

  def handle_event("log_outbound_flight", %{"flight" => flight}, socket) do
    {:noreply,
     prepend_line(
       socket,
       "#{flight} outbound, climbing out over the Davis Strait"
     )}
  end

  @impl true
  def handle_info(:board_tick, socket) do
    if socket.assigns.clock_armed? do
      Process.send_after(self(), :board_tick, 60_000)
    end

    {:noreply,
     socket
     |> assign(:station_clock, Time.add(socket.assigns.station_clock, 60, :second))
     |> assign(:tick_count, socket.assigns.tick_count + 1)
     |> prepend_line(
       "Board clock ticked to #{Calendar.strftime(Time.add(socket.assigns.station_clock, 60, :second), "%H:%M")}"
     )}
  end

  @impl true
  def terminate(reason, socket) do
    NuukDepartureDesk.record(%{
      controller: socket.assigns[:watch] && socket.assigns.watch.controller,
      watch: socket.assigns[:watch] && socket.assigns.watch.name,
      reason: reason,
      connected_mount?: socket.assigns[:connected_mount?]
    })

    :ok
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 13 · Nuuk night board
      </p>

      <h1>Nuuk night board</h1>
      <p class="lede">
        Controller {@watch.controller} keeps the night board at {@station},
        working the Dash 8-200. The static render is paper. The connected
        process arms the clock, posts traffic, and records a departure in <code>terminate/2</code>
        when the socket leaves.
      </p>

      <p
        id="mount-banner"
        class={["mount-banner", if(@connected_mount?, do: "connected-mount", else: "static-mount")]}
      >
        <%= if @connected_mount? do %>
          Socket connected. The night board clock is armed.
        <% else %>
          Static mount. No LiveView process, so terminate/2 will not run.
        <% end %>
      </p>

      <div class="watch-switcher">
        <.link
          id="first-watch"
          patch={
            ~p"/features/06-liveview-lifecycle-and-events/13-nuuk-night-board?#{[watch: "first"]}"
          }
        >
          First watch
        </.link>
        <.link
          id="midwatch"
          patch={~p"/features/06-liveview-lifecycle-and-events/13-nuuk-night-board?#{[watch: "mid"]}"}
        >
          Midwatch
        </.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Watch</dt>
        <dd id="watch-name">{@watch.name} ({@watch.window})</dd>
        <dt>Controller</dt>
        <dd id="controller-name">{@watch.controller}</dd>
        <dt>Board clock</dt>
        <dd id="station-clock">{Calendar.strftime(@station_clock, "%H:%M")}</dd>
        <dt>Clock</dt>
        <dd id="clock-armed">{if @clock_armed?, do: "armed", else: "quiet"}</dd>
        <dt>Ticks</dt>
        <dd id="tick-count">{@tick_count}</dd>
      </dl>

      <div class="watch-actions">
        <button
          id="log-inbound-greenland"
          type="button"
          phx-click="log_inbound_flight"
          phx-value-flight="Air Greenland 208"
        >
          Log inbound Air Greenland 208
        </button>
        <button
          id="log-outbound-dash"
          type="button"
          phx-click="log_outbound_flight"
          phx-value-flight="Dash 8-200"
        >
          Log outbound Dash 8-200
        </button>
      </div>

      <div class="scenario">
        <h2>Posted traffic</h2>
        <p :if={@traffic_lines == []} id="empty-board" class="muted">
          No traffic this watch.
        </p>
        <ol id="traffic-lines" class="watch-log">
          <li :for={line <- @traffic_lines} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :traffic_lines, [line | socket.assigns.traffic_lines])
  end
end
