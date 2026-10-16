# Verified routes · 01 · La Ferté-Alais signal flags
#
# Teaches:
# - ~p"/path" is a compile-time string that must match a router path
# - Static segments (no interpolation) are checked against the router
# - <.link navigate={~p"..."}> uses the sigil the same way a redirect would
# - A second static path on the same LiveView is a different verified route

defmodule PhoenixMultivitaminWeb.LaFerteAlaisSignalFlagsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "La Ferté-Alais signal flags")
     |> assign(:station, "La Ferté-Alais")
     |> assign(:marshal, "Clémence")
     |> assign(:flying, "gale")}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    board = if socket.assigns.live_action == :night, do: :night, else: :day

    {:noreply,
     socket
     |> assign(:board, board)
     |> assign(:day_path, day_board_path())
     |> assign(:night_path, night_board_path())}
  end

  @impl true
  def handle_event("hoist_crosswind", _params, socket) do
    {:noreply, assign(socket, :flying, "crosswind")}
  end

  def handle_event("hoist_gale", _params, socket) do
    {:noreply, assign(socket, :flying, "gale")}
  end

  def handle_event("hoist_storm", _params, socket) do
    {:noreply, assign(socket, :flying, "storm")}
  end

  def day_board_path, do: ~p"/features/02-verified-routes/01-la-ferte-alais-signal-flags"

  def night_board_path, do: ~p"/features/02-verified-routes/01-la-ferte-alais-signal-flags/night"

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 01 · La Ferté-Alais signal flags
      </p>

      <h1>La Ferté-Alais signal flags</h1>
      <p class="lede">
        Marshal {@marshal} hoists weather flags for the Spitfire Mk IX line at {@station}.
        Day and night boards are two compile-time ~p paths, not concatenated strings.
      </p>

      <p id="board-banner" class={["mount-banner", if(@board == :night, do: "connected-mount")]}>
        <%= if @board == :night do %>
          Night board. The floodlights read the same flags along the grass strip.
        <% else %>
          Day board. Checkered pennants against the Cerny grass.
        <% end %>
      </p>

      <div class="watch-switcher">
        <.link id="day-board-link" navigate={@day_path}>Day board</.link>
        <.link id="night-board-link" navigate={@night_path}>Night board</.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Marshal</dt>
        <dd id="marshal-name">{@marshal}</dd>
        <dt>Flying</dt>
        <dd id="flying-flag">{@flying}</dd>
        <dt>Day path</dt>
        <dd id="day-board-path">{@day_path}</dd>
        <dt>Night path</dt>
        <dd id="night-board-path">{@night_path}</dd>
      </dl>

      <div class="watch-actions">
        <button id="hoist-crosswind" type="button" phx-click="hoist_crosswind">
          Crosswind
        </button>
        <button id="hoist-gale" type="button" phx-click="hoist_gale">Gale</button>
        <button id="hoist-storm" type="button" phx-click="hoist_storm">Storm</button>
      </div>

      <div class="scenario">
        <h2>Hoist</h2>
        <p id="hoist-copy">
          {@flying} warning is flying on the {@board} board at La Ferté-Alais.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
