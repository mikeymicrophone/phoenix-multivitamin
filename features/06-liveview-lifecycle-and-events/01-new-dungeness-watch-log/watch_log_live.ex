# LiveView lifecycle and events · 01 · New Dungeness watch log
#
# Teaches:
# - mount/3 runs on the disconnected render and again when the socket connects
# - Start a send_after clock only when connected?/1 is true
# - handle_params/3 reads the watch name from the URL
# - handle_event/3 appends fog, vessel, wick, and bell lines to the log
# - handle_info/2 ticks the station clock without a client round-trip

defmodule PhoenixMultivitaminWeb.NewDungenessWatchLogLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @watches %{
    "evening" => %{
      name: "Evening watch",
      window: "20:00–00:00",
      keeper: "Maren",
      clock: ~T[20:00:00]
    },
    "midwatch" => %{
      name: "Midwatch",
      window: "00:00–04:00",
      keeper: "Alden",
      clock: ~T[00:00:00]
    }
  }

  @impl true
  def mount(_params, _session, socket) do
    connected_mount? = connected?(socket)

    socket =
      socket
      |> assign(:page_title, "New Dungeness watch log")
      |> assign(:station, "New Dungeness Light Station")
      |> assign(:connected_mount?, connected_mount?)
      |> assign(:log_lines, [])
      |> assign(:tick_count, 0)

    socket =
      if connected_mount? do
        Process.send_after(self(), :station_tick, 60_000)
        assign(socket, :clock_armed?, true)
      else
        assign(socket, :clock_armed?, false)
      end

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    watch_key = Map.get(params, "watch", "evening")
    watch = Map.get(@watches, watch_key, @watches["evening"])

    {:noreply,
     socket
     |> assign(:watch_key, watch_key)
     |> assign(:watch, watch)
     |> assign_new(:station_clock, fn -> watch.clock end)
     |> maybe_reset_clock(watch)}
  end

  @impl true
  def handle_event("log_fog_bank", _params, socket) do
    {:noreply,
     prepend_line(
       socket,
       "Fog bank over the spit, visibility two cable lengths"
     )}
  end

  def handle_event("log_passing_tug", _params, socket) do
    {:noreply,
     prepend_line(
       socket,
       "Cannery tender Retort passing east, two short blasts"
     )}
  end

  def handle_event("trim_wick", _params, socket) do
    {:noreply, prepend_line(socket, "Lamp wick trimmed to three-eighths inch")}
  end

  def handle_event("strike_watch_bell", _params, socket) do
    {:noreply, prepend_line(socket, "Watch bell struck for the hour")}
  end

  @impl true
  def handle_info(:station_tick, socket) do
    if socket.assigns.clock_armed? do
      Process.send_after(self(), :station_tick, 60_000)
    end

    {:noreply,
     socket
     |> assign(:station_clock, Time.add(socket.assigns.station_clock, 60, :second))
     |> assign(:tick_count, socket.assigns.tick_count + 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 01 · New Dungeness watch log
      </p>

      <h1>New Dungeness watch log</h1>
      <p class="lede">
        Keeper {@watch.keeper} posts the {@watch.name} at {@station}. The
        static render is a paper log. The connected mount arms the station clock.
      </p>

      <p
        id="mount-banner"
        class={["mount-banner", if(@connected_mount?, do: "connected-mount", else: "static-mount")]}
      >
        <%= if @connected_mount? do %>
          Socket connected. Watch clock is armed on the connected mount.
        <% else %>
          Static mount. The watch clock stays quiet until the socket connects.
        <% end %>
      </p>

      <div class="watch-switcher">
        <.link
          id="evening-watch"
          patch={
            ~p"/features/06-liveview-lifecycle-and-events/01-new-dungeness-watch-log?#{[watch: "evening"]}"
          }
        >
          Evening watch
        </.link>
        <.link
          id="midwatch"
          patch={
            ~p"/features/06-liveview-lifecycle-and-events/01-new-dungeness-watch-log?#{[watch: "midwatch"]}"
          }
        >
          Midwatch
        </.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Watch</dt>
        <dd id="watch-name">{@watch.name} ({@watch.window})</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@watch.keeper}</dd>
        <dt>Station clock</dt>
        <dd id="station-clock">{Calendar.strftime(@station_clock, "%H:%M")}</dd>
        <dt>Clock</dt>
        <dd id="clock-armed">{if @clock_armed?, do: "armed", else: "quiet"}</dd>
      </dl>

      <div class="watch-actions">
        <button id="log-fog-bank" type="button" phx-click="log_fog_bank">Log fog bank</button>
        <button id="log-passing-tug" type="button" phx-click="log_passing_tug">
          Log passing tug
        </button>
        <button id="trim-wick" type="button" phx-click="trim_wick">Trim wick</button>
        <button id="strike-watch-bell" type="button" phx-click="strike_watch_bell">
          Strike watch bell
        </button>
      </div>

      <div class="scenario">
        <h2>Posted lines</h2>
        <p :if={@log_lines == []} id="empty-log" class="muted">No lines posted this watch.</p>
        <ol id="watch-entries" class="watch-log">
          <li :for={line <- @log_lines} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp maybe_reset_clock(socket, watch) do
    assign(socket, :station_clock, watch.clock)
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :log_lines, [line | socket.assigns.log_lines])
  end
end
