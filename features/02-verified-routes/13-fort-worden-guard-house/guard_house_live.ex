# Verified routes · 13 · Fort Worden guard house
#
# Teaches:
# - Capstone: one ~p board path shared by a controller redirect, a LiveView,
#   patch/navigate, interpolated passes, query strings, a static plate, url/1,
#   and a mailer
# - The gate controller, relief board, and pass cards are extra verified routes
# - Named functions wrap ~p so every surface cites the same helper

defmodule PhoenixMultivitaminWeb.FortWordenGuardHouseLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.FortWordenGuardHouseController
  alias PhoenixMultivitaminWeb.FortWordenGuardHouseMailer

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Fort Worden guard house")
     |> assign(:station, "Fort Worden guard house")
     |> assign(:sentry, "Corin")
     |> assign(:sentry_email, "corin@fortworden.wa.gov")
     |> assign(:last_letter, nil)
     |> assign(:mounts, 1)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    watch = Map.get(params, "watch", "day")
    gate = Map.get(params, "gate", "shut")
    pass = Map.get(params, "pass")

    surface =
      cond do
        socket.assigns.live_action == :relief -> :relief
        socket.assigns.live_action == :pass -> :pass
        true -> :board
      end

    {:noreply,
     socket
     |> assign(:watch, watch)
     |> assign(:gate, gate)
     |> assign(:pass, pass)
     |> assign(:surface, surface)
     |> assign(:board_path, board_path())
     |> assign(:evening_path, evening_board_path())
     |> assign(:relief_path, relief_path())
     |> assign(:gate_path, FortWordenGuardHouseController.gate_path())
     |> assign(:kinzie_path, pass_path("kinzie"))
     |> assign(:board_url, FortWordenGuardHouseMailer.board_url())
     |> assign(:plate_path, ~p"/images/logo.svg")}
  end

  def board_path, do: ~p"/features/02-verified-routes/13-fort-worden-guard-house"

  def evening_board_path do
    ~p"/features/02-verified-routes/13-fort-worden-guard-house?#{[watch: "evening"]}"
  end

  def relief_path, do: ~p"/features/02-verified-routes/13-fort-worden-guard-house/relief"

  def pass_path(pass) do
    ~p"/features/02-verified-routes/13-fort-worden-guard-house/passes/#{pass}"
  end

  @impl true
  def handle_event("patch_evening", _params, socket) do
    {:noreply, push_patch(socket, to: evening_board_path())}
  end

  def handle_event("navigate_relief", _params, socket) do
    {:noreply, push_navigate(socket, to: relief_path())}
  end

  def handle_event("issue_kinzie_pass", _params, socket) do
    {:ok, email} =
      FortWordenGuardHouseMailer.deliver_pass(
        socket.assigns.sentry,
        socket.assigns.sentry_email,
        "kinzie"
      )

    {:noreply,
     socket
     |> assign(:last_letter, email.subject)
     |> push_navigate(to: pass_path("kinzie"))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 13 · Fort Worden guard house
      </p>

      <h1>Fort Worden guard house</h1>
      <p class="lede">
        Sentry {@sentry} posts the board at the {@station} above Port Townsend.
        The gate controller, this LiveView, the relief walk, Battery Kinzie
        passes, the characteristic plate, and the mailer all cite the same ~p
        helpers.
      </p>

      <p
        id="surface-banner"
        class={["mount-banner", if(@surface != :board, do: "connected-mount")]}
      >
        <%= cond do %>
          <% @surface == :relief -> %>
            Relief walk along Artillery Hill. This is a new mount.
          <% @surface == :pass -> %>
            Battery {String.capitalize(@pass || "kinzie")} paper pass.
          <% true -> %>
            Guard house board. Patching the watch keeps this socket.
        <% end %>
      </p>

      <div class="watch-switcher">
        <.link id="board-link" navigate={@board_path}>Board</.link>
        <.link id="evening-link" patch={@evening_path}>Evening watch</.link>
        <.link id="relief-link" navigate={@relief_path}>Relief walk</.link>
        <.link id="kinzie-link" navigate={@kinzie_path}>Battery Kinzie</.link>
        <.link id="gate-link" href={@gate_path}>Open the gate</.link>
      </div>

      <dl class="station-meta">
        <dt>Post</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Sentry</dt>
        <dd id="sentry-name">{@sentry}</dd>
        <dt>Watch</dt>
        <dd id="watch-name">{@watch}</dd>
        <dt>Gate</dt>
        <dd id="gate-state">{@gate}</dd>
        <dt>Surface</dt>
        <dd id="surface-name">{@surface}</dd>
        <dt>Pass</dt>
        <dd id="pass-name">{@pass || "none"}</dd>
        <dt>Mounts</dt>
        <dd id="mount-count">{@mounts}</dd>
        <dt>Board path</dt>
        <dd id="board-path">{@board_path}</dd>
        <dt>Board URL</dt>
        <dd id="board-url">{@board_url}</dd>
        <dt>Gate path</dt>
        <dd id="gate-path">{@gate_path}</dd>
        <dt>Relief path</dt>
        <dd id="relief-path">{@relief_path}</dd>
        <dt>Kinzie path</dt>
        <dd id="kinzie-path">{@kinzie_path}</dd>
        <dt>Plate</dt>
        <dd id="plate-path">{@plate_path}</dd>
        <dt>Last letter</dt>
        <dd id="last-letter">{@last_letter || "none"}</dd>
      </dl>

      <div class="watch-actions">
        <button id="patch-evening" type="button" phx-click="patch_evening">
          Patch evening
        </button>
        <button id="navigate-relief" type="button" phx-click="navigate_relief">
          Start relief walk
        </button>
        <button id="issue-kinzie" type="button" phx-click="issue_kinzie_pass">
          Issue Kinzie pass
        </button>
      </div>

      <div class="scenario">
        <h2>Post</h2>
        <p id="post-copy">
          {@sentry} on {@watch} watch, gate {@gate}, {@surface} surface.
        </p>
        <img
          id="guard-plate"
          src={@plate_path}
          alt="Fort Worden characteristic plate"
          width="72"
          height="72"
        />
      </div>
    </Layouts.catalog>
    """
  end
end
