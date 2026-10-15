# Verified routes · 06 · Browns Point fog desk
#
# Teaches:
# - push_patch(socket, to: ~p"...") reuses the LiveView and runs handle_params/3
# - push_navigate(socket, to: ~p"...") mounts again, even on the same module
# - <.link patch={~p}> vs <.link navigate={~p}> are the same two motions
# - live_action distinguishes the desk from the horn cabinet

defmodule PhoenixMultivitaminWeb.BrownsPointFogDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Browns Point fog desk")
     |> assign(:station, "Browns Point Light")
     |> assign(:mounts, 1)
     |> assign(:horn_blasts, 0)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    watch = Map.get(params, "watch", "evening")
    keeper = if watch == "midwatch", do: "Nola", else: "Pax"

    surface = if socket.assigns.live_action == :horn, do: :horn, else: :desk

    {:noreply,
     socket
     |> assign(:watch, watch)
     |> assign(:keeper, keeper)
     |> assign(:surface, surface)
     |> assign(:desk_path, desk_path())
     |> assign(:midwatch_path, midwatch_path())
     |> assign(:horn_path, horn_cabinet_path())}
  end

  @impl true
  def handle_event("patch_midwatch", _params, socket) do
    {:noreply, push_patch(socket, to: midwatch_path())}
  end

  def handle_event("navigate_horn", _params, socket) do
    {:noreply, push_navigate(socket, to: horn_cabinet_path())}
  end

  def handle_event("sound_horn", _params, socket) do
    {:noreply, assign(socket, :horn_blasts, socket.assigns.horn_blasts + 1)}
  end

  def desk_path, do: ~p"/features/02-verified-routes/06-browns-point-fog-desk"

  def midwatch_path do
    ~p"/features/02-verified-routes/06-browns-point-fog-desk?#{[watch: "midwatch"]}"
  end

  def horn_cabinet_path,
    do: ~p"/features/02-verified-routes/06-browns-point-fog-desk/horn-cabinet"

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 06 · Browns Point fog desk
      </p>

      <h1>Browns Point fog desk</h1>
      <p class="lede">
        {@keeper} keeps the fog desk at {@station} on Commencement Bay.
        Patching the watch reuses this process. Opening the horn cabinet
        navigates to a second verified path and mounts again.
      </p>

      <p
        id="surface-banner"
        class={["mount-banner", if(@surface == :horn, do: "connected-mount")]}
      >
        <%= if @surface == :horn do %>
          Horn cabinet. The compressor stands one landing below the desk.
        <% else %>
          Fog desk. Watch patch stays on this socket.
        <% end %>
      </p>

      <div class="watch-switcher">
        <.link id="evening-desk-link" patch={@desk_path}>Evening desk</.link>
        <.link id="midwatch-desk-link" patch={@midwatch_path}>Midwatch</.link>
        <.link id="horn-cabinet-link" navigate={@horn_path}>Horn cabinet</.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Watch</dt>
        <dd id="watch-name">{@watch}</dd>
        <dt>Surface</dt>
        <dd id="surface-name">{@surface}</dd>
        <dt>Mounts this process</dt>
        <dd id="mount-count">{@mounts}</dd>
        <dt>Horn blasts</dt>
        <dd id="horn-blasts">{@horn_blasts}</dd>
        <dt>Desk path</dt>
        <dd id="desk-path">{@desk_path}</dd>
        <dt>Horn path</dt>
        <dd id="horn-path">{@horn_path}</dd>
      </dl>

      <div class="watch-actions">
        <button id="patch-midwatch" type="button" phx-click="patch_midwatch">
          Patch midwatch
        </button>
        <button id="navigate-horn" type="button" phx-click="navigate_horn">
          Open horn cabinet
        </button>
        <button id="sound-horn" type="button" phx-click="sound_horn">Sound horn</button>
      </div>

      <div class="scenario">
        <h2>Desk log</h2>
        <p id="desk-copy">
          {@keeper} on {@watch}, {@surface} surface, {@mounts} mount(s) on this socket.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
