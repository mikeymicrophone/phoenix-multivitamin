# Verified routes · 10 · Addis ramp tickets
#
# Teaches:
# - forward/2 in the main router: ~p must include the kiosk prefix
# - Main-router ~p"/.../kiosk/lane/2" is verified through the forwarded router
# - The kiosk's own ~p"/lane/2" does not include that prefix

defmodule PhoenixMultivitaminWeb.AddisRampTicketsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Addis ramp tickets")
     |> assign(:station, "Addis Ababa Bole ramp")
     |> assign(:lead, "Selam")
     |> assign(:board_path, board_path())
     |> assign(:lane_two_path, lane_path(2))
     |> assign(:lane_three_path, lane_path(3))}
  end

  def board_path, do: ~p"/features/02-verified-routes/10-addis-ramp-tickets"

  def lane_path(lane) do
    ~p"/features/02-verified-routes/10-addis-ramp-tickets/kiosk/lane/#{lane}"
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 10 · Addis ramp tickets
      </p>

      <h1>Addis ramp tickets</h1>
      <p class="lede">
        Ramp lead {@lead} issues stand tickets at the {@station} for the
        De Havilland Q400. The kiosk is a forwarded Phoenix.Router. Links from
        this board include the kiosk prefix in ~p so they verify on the main router.
      </p>

      <dl class="station-meta">
        <dt>Ramp</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Lead</dt>
        <dd id="lead-name">{@lead}</dd>
        <dt>Board path</dt>
        <dd id="board-path">{@board_path}</dd>
        <dt>Lane 2</dt>
        <dd id="lane-two-path">{@lane_two_path}</dd>
        <dt>Lane 3</dt>
        <dd id="lane-three-path">{@lane_three_path}</dd>
      </dl>

      <div class="watch-actions">
        <.link id="open-lane-two" href={@lane_two_path}>Open lane 2</.link>
        <.link id="open-lane-three" href={@lane_three_path}>Open lane 3</.link>
      </div>

      <div class="scenario">
        <h2>Hold</h2>
        <p id="hold-copy">
          Aircraft stage on the Bole apron. The kiosk prefix is part of
          the verified path, not an afterthought.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
