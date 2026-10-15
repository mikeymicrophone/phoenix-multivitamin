# Verified routes · 09 · Point Robinson bell relay
#
# Teaches:
# - The LiveView and the mailer share one ~p path
# - Relaying the watch delivers an email whose HTML href is url(~p"...")
# - A mailer has no conn; url/1 still builds a host from the endpoint

defmodule PhoenixMultivitaminWeb.PointRobinsonBellRelayLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.PointRobinsonBellRelayMailer

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Point Robinson bell relay")
     |> assign(:station, "Point Robinson Light")
     |> assign(:keeper, "Leda")
     |> assign(:keeper_email, "leda@pointrobinson.wa.gov")
     |> assign(:last_relay, nil)
     |> assign(:board_path, board_path())
     |> assign(:board_url, PointRobinsonBellRelayMailer.board_url())}
  end

  def board_path, do: ~p"/features/02-verified-routes/09-point-robinson-bell-relay"

  @impl true
  def handle_event("relay_watch", _params, socket) do
    {:ok, email} =
      PointRobinsonBellRelayMailer.deliver_bell_watch(
        socket.assigns.keeper,
        socket.assigns.keeper_email
      )

    {:noreply, assign(socket, :last_relay, email.subject)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 09 · Point Robinson bell relay
      </p>

      <h1>Point Robinson bell relay</h1>
      <p class="lede">
        Keeper {@keeper} takes the bell watch at {@station} on Maury Island.
        Relaying the watch mails her the same url(~p) the board itself uses.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Board path</dt>
        <dd id="board-path">{@board_path}</dd>
        <dt>Board URL</dt>
        <dd id="board-url">{@board_url}</dd>
        <dt>Last relay</dt>
        <dd id="last-relay">{@last_relay || "none"}</dd>
      </dl>

      <div class="watch-actions">
        <button id="relay-watch" type="button" phx-click="relay_watch">Relay the watch</button>
      </div>

      <div class="scenario">
        <h2>Bell</h2>
        <p id="bell-copy">
          Strike once at the quarter. The mailer sends {@keeper} to {@board_url}.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
