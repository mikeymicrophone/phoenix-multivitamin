# LiveView lifecycle and events · 10 · Cattle Point range log
#
# Teaches:
# - A regular assign keeps its value across renders
# - temporary_assigns reset to the mount value after every render
# - The reset does not patch the DOM until that key is assigned again
# - Reading the assign in a later event sees the reset value, not what the DOM still shows

defmodule PhoenixMultivitaminWeb.CattlePointRangeLogLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Cattle Point range log")
     |> assign(:station, "Cattle Point Light")
     |> assign(:keeper, "Briony")
     |> assign(:pass, "Cattle Pass")
     |> assign(:posted_bearings, [])
     |> assign(:last_sighting, nil)
     |> assign(:last_event, nil)
     |> assign(:readback, "none"), temporary_assigns: [last_sighting: nil]}
  end

  @impl true
  def handle_event("log_front_range", _params, socket) do
    sighting = "Front range on the Cattle Point scaffold, red over red"

    {:noreply,
     socket
     |> assign(:last_sighting, sighting)
     |> assign(:last_event, "front_range")
     |> append_bearing(sighting)}
  end

  def handle_event("log_rear_range", _params, socket) do
    sighting = "Rear range on the bluff, white over the front"

    {:noreply,
     socket
     |> assign(:last_sighting, sighting)
     |> assign(:last_event, "rear_range")
     |> append_bearing(sighting)}
  end

  def handle_event("log_ferry_wake", _params, socket) do
    {:noreply,
     socket
     |> assign(:last_event, "ferry_wake")
     |> append_bearing("Washington State Ferries wake crossing the range")}
  end

  def handle_event("confirm_last_sighting", _params, socket) do
    {:noreply,
     socket
     |> assign(:last_event, "confirm")
     |> assign(:readback, socket.assigns.last_sighting || "cleared")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 10 · Cattle Point range log
      </p>

      <h1>Cattle Point range log</h1>
      <p class="lede">
        Keeper {@keeper} logs the range lights at {@station}, looking down {@pass}. Posted bearings are a regular assign. The last sighting is
        temporary: it renders once, then resets.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Last event</dt>
        <dd id="last-event">{@last_event || "none"}</dd>
        <dt>Last sighting</dt>
        <dd id="last-sighting">{@last_sighting || "none"}</dd>
        <dt>Readback</dt>
        <dd id="sighting-readback">{@readback}</dd>
        <dt>Bearings posted</dt>
        <dd id="bearing-count">{length(@posted_bearings)}</dd>
      </dl>

      <div class="watch-actions">
        <button id="log-front-range" type="button" phx-click="log_front_range">
          Log front range
        </button>
        <button id="log-rear-range" type="button" phx-click="log_rear_range">
          Log rear range
        </button>
        <button id="log-ferry-wake" type="button" phx-click="log_ferry_wake">
          Log ferry wake
        </button>
        <button id="confirm-last-sighting" type="button" phx-click="confirm_last_sighting">
          Confirm last sighting
        </button>
      </div>

      <div class="scenario">
        <h2>Posted bearings</h2>
        <p :if={@posted_bearings == []} id="empty-log" class="muted">
          No bearings posted this watch.
        </p>
        <ol id="posted-bearings" class="watch-log">
          <li :for={line <- @posted_bearings} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp append_bearing(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :posted_bearings, socket.assigns.posted_bearings ++ [line])
  end
end
