# Verified routes · 09 · Accra slot relay
#
# Teaches:
# - The LiveView and the mailer share one ~p path
# - Relaying the watch delivers an email whose HTML href is url(~p"...")
# - A mailer has no conn; url/1 still builds a host from the endpoint

defmodule PhoenixMultivitaminWeb.AccraSlotRelayLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.AccraSlotRelayMailer

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Accra slot relay")
     |> assign(:station, "Accra Kotoka slot board")
     |> assign(:clerk, "Kwame")
     |> assign(:clerk_email, "kwame@kotoka.gov.gh")
     |> assign(:last_relay, nil)
     |> assign(:board_path, board_path())
     |> assign(:board_url, AccraSlotRelayMailer.board_url())}
  end

  def board_path, do: ~p"/features/02-verified-routes/09-accra-slot-relay"

  @impl true
  def handle_event("relay_watch", _params, socket) do
    {:ok, email} =
      AccraSlotRelayMailer.deliver_slot_watch(
        socket.assigns.clerk,
        socket.assigns.clerk_email
      )

    {:noreply, assign(socket, :last_relay, email.subject)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 09 · Accra slot relay
      </p>

      <h1>Accra slot relay</h1>
      <p class="lede">
        Slot clerk {@clerk} takes the slot watch at {@station} for the
        Boeing 777-300ER. Relaying the watch mails him the same url(~p) the board itself uses.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
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
        <h2>Slot</h2>
        <p id="slot-copy">
          Hold the 777-300ER at the quarter. The mailer sends {@clerk} to {@board_url}.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
