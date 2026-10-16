# LiveView navigation · 13 · Rio Grande Fuegian watch
#
# Teaches:
# - Capstone: patch inside a watch, navigate to the relief board
# - Watch clicks survive a patch and die on navigate

defmodule PhoenixMultivitaminWeb.RioGrandeFuegianWatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Rio Grande Fuegian watch")
     |> assign(:clerk, "Belén")
     |> assign(:craft, "Beech 1900")
     |> assign(:clicks, 0)
     |> assign(:mounts, 1)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    watch = Map.get(params, "watch", "evening")
    {:noreply, assign(socket, :watch, watch)}
  end

  @impl true
  def handle_event("log_click", _params, socket) do
    {:noreply, assign(socket, :clicks, socket.assigns.clicks + 1)}
  end

  def handle_event("patch_midwatch", _params, socket) do
    {:noreply,
     push_patch(socket,
       to: ~p"/features/07-liveview-navigation/13-rio-grande-fuegian-watch?#{[watch: "midwatch"]}"
     )}
  end

  def handle_event("open_relief", _params, socket) do
    {:noreply,
     push_navigate(socket,
       to: ~p"/features/07-liveview-navigation/13-rio-grande-fuegian-watch/relief"
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 13 · Rio Grande Fuegian watch
      </p>

      <h1>Rio Grande Fuegian watch</h1>
      <p class="lede">
        Clerk {@clerk} patches the {@craft} watch, then navigates to relief.
        Clicks survive the patch. Relief is a new process.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="watch-name">{@watch}</p>
      <p id="watch-clicks">{@clicks}</p>
      <p id="mount-count">{@mounts}</p>
      <p id="surface-name">watch</p>

      <button id="log-click" type="button" phx-click="log_click">Log click</button>
      <button id="patch-midwatch" type="button" phx-click="patch_midwatch">Patch midwatch</button>
      <button id="open-relief" type="button" phx-click="open_relief">Open relief</button>
    </Layouts.catalog>
    """
  end
end
