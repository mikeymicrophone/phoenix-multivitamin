# JS commands · 11 · Ittoqqortoormiit ignore
#
# Teaches:
# - JS.ignore_attributes/1 during a patch

defmodule PhoenixMultivitaminWeb.IttoqqortoormiitIgnoreLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Ittoqqortoormiit ignore")
     |> assign(:clerk, "Aputsiaq")
     |> assign(:craft, "Bell 412")
     |> assign(:ticks, 0)}
  end

  @impl true
  def handle_event("tick_scoresbysund", _params, socket) do
    {:noreply, assign(socket, :ticks, socket.assigns.ticks + 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 11 · Ittoqqortoormiit ignore
      </p>

      <h1>Ittoqqortoormiit ignore</h1>
      <p class="lede">
        Clerk {@clerk} keeps the icing dialog open on the {@craft} through a
        patch by ignoring the open attribute.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="sund-ticks">{@ticks}</p>

      <button id="tick-sund" type="button" phx-click="tick_scoresbysund">
        Tick Scoresbysund
      </button>

      <dialog
        id="icing-dialog"
        open
        phx-mounted={JS.ignore_attributes(["open"], to: "#icing-dialog")}
      >
        Icing dialog stays open.
      </dialog>
    </Layouts.catalog>
    """
  end
end
