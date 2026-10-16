# LiveView navigation · 08 · Banjul hold navigate
#
# Teaches:
# - push_navigate from an event mounts the stack LiveView
# - Desk assigns do not travel

defmodule PhoenixMultivitaminWeb.BanjulHoldNavigateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Banjul hold navigate")
     |> assign(:clerk, "Fatou")
     |> assign(:craft, "CRJ200")
     |> assign(:ticks, 0)}
  end

  @impl true
  def handle_event("tick_desk", _params, socket) do
    {:noreply, assign(socket, :ticks, socket.assigns.ticks + 1)}
  end

  def handle_event("open_stack", _params, socket) do
    {:noreply,
     push_navigate(socket, to: ~p"/features/07-liveview-navigation/08-banjul-hold-navigate/stack")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 08 · Banjul hold navigate
      </p>

      <h1>Banjul hold navigate</h1>
      <p class="lede">
        Clerk {@clerk} sends the {@craft} to the hold stack from a button.
        That is <code>push_navigate/2</code>, not a link.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="desk-ticks">{@ticks}</p>
      <p id="surface-name">desk</p>

      <button id="tick-desk" type="button" phx-click="tick_desk">Tick desk</button>
      <button id="open-stack" type="button" phx-click="open_stack">Open stack</button>
    </Layouts.catalog>
    """
  end
end
