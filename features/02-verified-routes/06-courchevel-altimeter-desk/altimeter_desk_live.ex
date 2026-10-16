# Verified routes · 06 · Courchevel altimeter desk
#
# Teaches:
# - push_patch(socket, to: ~p"...") reuses the LiveView and runs handle_params/3
# - push_navigate(socket, to: ~p"...") mounts again, even on the same module
# - <.link patch={~p}> vs <.link navigate={~p}> are the same two motions
# - live_action distinguishes the desk from the altimeter cabinet

defmodule PhoenixMultivitaminWeb.CourchevelAltimeterDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Courchevel altimeter desk")
     |> assign(:station, "Courchevel altimeter desk")
     |> assign(:mounts, 1)
     |> assign(:cabinet_clicks, 0)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    watch = Map.get(params, "watch", "evening")
    clerk = if watch == "midwatch", do: "Odile", else: "Yves"

    surface = if socket.assigns.live_action == :cabinet, do: :cabinet, else: :desk

    {:noreply,
     socket
     |> assign(:watch, watch)
     |> assign(:clerk, clerk)
     |> assign(:surface, surface)
     |> assign(:desk_path, desk_path())
     |> assign(:midwatch_path, midwatch_path())
     |> assign(:cabinet_path, altimeter_cabinet_path())}
  end

  @impl true
  def handle_event("patch_midwatch", _params, socket) do
    {:noreply, push_patch(socket, to: midwatch_path())}
  end

  def handle_event("navigate_cabinet", _params, socket) do
    {:noreply, push_navigate(socket, to: altimeter_cabinet_path())}
  end

  def handle_event("log_click", _params, socket) do
    {:noreply, assign(socket, :cabinet_clicks, socket.assigns.cabinet_clicks + 1)}
  end

  def desk_path, do: ~p"/features/02-verified-routes/06-courchevel-altimeter-desk"

  def midwatch_path do
    ~p"/features/02-verified-routes/06-courchevel-altimeter-desk?#{[watch: "midwatch"]}"
  end

  def altimeter_cabinet_path,
    do: ~p"/features/02-verified-routes/06-courchevel-altimeter-desk/altimeter-cabinet"

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 06 · Courchevel altimeter desk
      </p>

      <h1>Courchevel altimeter desk</h1>
      <p class="lede">
        {@clerk} keeps the altimeter desk at {@station} for the Pilatus PC-12.
        Patching the watch reuses this process. Opening the altimeter cabinet
        navigates to a second verified path and mounts again.
      </p>

      <p
        id="surface-banner"
        class={["mount-banner", if(@surface == :cabinet, do: "connected-mount")]}
      >
        <%= if @surface == :cabinet do %>
          Altimeter cabinet. The Kollsman window stands one landing below the desk.
        <% else %>
          Altimeter desk. Watch patch stays on this socket.
        <% end %>
      </p>

      <div class="watch-switcher">
        <.link id="evening-desk-link" patch={@desk_path}>Evening desk</.link>
        <.link id="midwatch-desk-link" patch={@midwatch_path}>Midwatch</.link>
        <.link id="altimeter-cabinet-link" navigate={@cabinet_path}>Altimeter cabinet</.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
        <dt>Watch</dt>
        <dd id="watch-name">{@watch}</dd>
        <dt>Surface</dt>
        <dd id="surface-name">{@surface}</dd>
        <dt>Mounts this process</dt>
        <dd id="mount-count">{@mounts}</dd>
        <dt>Cabinet clicks</dt>
        <dd id="cabinet-clicks">{@cabinet_clicks}</dd>
        <dt>Desk path</dt>
        <dd id="desk-path">{@desk_path}</dd>
        <dt>Cabinet path</dt>
        <dd id="cabinet-path">{@cabinet_path}</dd>
      </dl>

      <div class="watch-actions">
        <button id="patch-midwatch" type="button" phx-click="patch_midwatch">
          Patch midwatch
        </button>
        <button id="navigate-cabinet" type="button" phx-click="navigate_cabinet">
          Open altimeter cabinet
        </button>
        <button id="log-click" type="button" phx-click="log_click">Log click</button>
      </div>

      <div class="scenario">
        <h2>Desk log</h2>
        <p id="desk-copy">
          {@clerk} on {@watch}, {@surface} surface, {@mounts} mount(s) on this socket.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
