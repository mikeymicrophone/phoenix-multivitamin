# LiveView lifecycle and events · 01 · Akureyri night watch
#
# Teaches:
# - mount/3 runs on the disconnected render and again when the socket connects
# - Start a send_after clock only when connected?/1 is true
# - handle_params/3 reads the watch name from the URL
# - handle_event/3 appends ice, inbound, ice-light, and ATIS lines to the log
# - handle_info/2 ticks the station clock without a client round-trip

defmodule PhoenixMultivitaminWeb.AkureyriNightWatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @watches %{
    "evening" => %{
      name: "Evening watch",
      window: "20:00–00:00",
      controller: "Sólrún",
      clock: ~T[20:00:00]
    },
    "midwatch" => %{
      name: "Midwatch",
      window: "00:00–04:00",
      controller: "Egill",
      clock: ~T[00:00:00]
    }
  }

  @impl true
  def mount(_params, _session, socket) do
    connected_mount? = connected?(socket)

    socket =
      socket
      |> assign(:page_title, "Akureyri night watch")
      |> assign(:station, "Akureyri Airport")
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
  def handle_event("log_ice_pellets", _params, socket) do
    {:noreply,
     prepend_line(
       socket,
       "Ice pellets on the apron, visibility two hundred metres"
     )}
  end

  def handle_event("log_fokker_inbound", _params, socket) do
    {:noreply,
     prepend_line(
       socket,
       "Fokker 50 inbound from Reykjavík, ice light set"
     )}
  end

  def handle_event("trim_ice_light", _params, socket) do
    {:noreply, prepend_line(socket, "Ice light trimmed to the threshold bar")}
  end

  def handle_event("strike_atis_bell", _params, socket) do
    {:noreply, prepend_line(socket, "ATIS bell struck for the hour")}
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
        · 01 · Akureyri night watch
      </p>

      <h1>Akureyri night watch</h1>
      <p class="lede">
        Controller {@watch.controller} posts the {@watch.name} at {@station}. The
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
            ~p"/features/06-liveview-lifecycle-and-events/01-akureyri-night-watch?#{[watch: "evening"]}"
          }
        >
          Evening watch
        </.link>
        <.link
          id="midwatch"
          patch={
            ~p"/features/06-liveview-lifecycle-and-events/01-akureyri-night-watch?#{[watch: "midwatch"]}"
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
        <dt>Controller</dt>
        <dd id="controller-name">{@watch.controller}</dd>
        <dt>Station clock</dt>
        <dd id="station-clock">{Calendar.strftime(@station_clock, "%H:%M")}</dd>
        <dt>Clock</dt>
        <dd id="clock-armed">{if @clock_armed?, do: "armed", else: "quiet"}</dd>
      </dl>

      <div class="watch-actions">
        <button id="log-ice-pellets" type="button" phx-click="log_ice_pellets">
          Log ice pellets
        </button>
        <button id="log-fokker-inbound" type="button" phx-click="log_fokker_inbound">
          Log the Fokker inbound
        </button>
        <button id="trim-ice-light" type="button" phx-click="trim_ice_light">Trim ice light</button>
        <button id="strike-atis-bell" type="button" phx-click="strike_atis_bell">
          Strike ATIS bell
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
