# Verified routes · 11 · Mukilteo fare banner
#
# Teaches:
# - Phoenix 1.8 routers set helpers: false; Router.Helpers is not generated
# - Named functions that return ~p replace login_path-style helpers
# - The function name is documentation; the sigil is still compile-checked
# - Interpolated lanes go through the same named function

defmodule PhoenixMultivitaminWeb.MukilteoFareBannerLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Mukilteo fare banner")
     |> assign(:station, "Mukilteo ferry terminal")
     |> assign(:clerk, "Ysolde")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    lane = Map.get(params, "lane", "walk-on")
    surface = if socket.assigns.live_action == :lane, do: :lane, else: :banner

    {:noreply,
     socket
     |> assign(:lane, lane)
     |> assign(:surface, surface)
     |> assign(:banner_path, fare_board_path())
     |> assign(:lane_two_path, vehicle_lane_path(2))
     |> assign(:lane_three_path, vehicle_lane_path("3"))}
  end

  @doc "Replacement for a retired fare_board_path helper."
  def fare_board_path, do: ~p"/features/02-verified-routes/11-mukilteo-fare-banner"

  @doc "Replacement for a retired vehicle_lane_path/1 helper."
  def vehicle_lane_path(lane) do
    ~p"/features/02-verified-routes/11-mukilteo-fare-banner/lanes/#{lane}"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 11 · Mukilteo fare banner
      </p>

      <h1>Mukilteo fare banner</h1>
      <p class="lede">
        Clerk {@clerk} hangs the fare banner at the {@station}. Named router
        helpers are gone (`helpers: false`). fare_board_path/0 and
        vehicle_lane_path/1 wrap ~p instead.
      </p>

      <p
        id="surface-banner"
        class={["mount-banner", if(@surface == :lane, do: "connected-mount")]}
      >
        <%= if @surface == :lane do %>
          Vehicle lane {@lane}. The banner still points here through vehicle_lane_path/1.
        <% else %>
          Walk-on banner. vehicle_lane_path/1 is how cars leave this board.
        <% end %>
      </p>

      <div class="watch-switcher">
        <.link id="banner-link" navigate={fare_board_path()}>Walk-on banner</.link>
        <.link id="lane-two-link" navigate={vehicle_lane_path(2)}>Lane 2</.link>
        <.link id="lane-three-link" navigate={vehicle_lane_path(3)}>Lane 3</.link>
      </div>

      <dl class="station-meta">
        <dt>Terminal</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
        <dt>Lane</dt>
        <dd id="lane-name">{@lane}</dd>
        <dt>fare_board_path/0</dt>
        <dd id="banner-path">{@banner_path}</dd>
        <dt>vehicle_lane_path(2)</dt>
        <dd id="lane-two-path">{@lane_two_path}</dd>
        <dt>vehicle_lane_path("3")</dt>
        <dd id="lane-three-path">{@lane_three_path}</dd>
      </dl>

      <div class="scenario">
        <h2>Fares</h2>
        <p id="fare-copy">
          Mukilteo–Clinton. {@lane} through a named function, not a Router.Helpers call.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
