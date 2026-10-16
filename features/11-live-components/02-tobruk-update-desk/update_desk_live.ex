# LiveComponents · 02 · Tobruk update desk
#
# Teaches:
# - update/2 instead of mount for later assigns

defmodule PhoenixMultivitaminWeb.TobrukUpdateDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.TobrukUpdateCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Tobruk update desk")
     |> assign(:clerk, "Iman")
     |> assign(:craft, "Antonov An-8")
     |> assign(:stand, "east")}
  end

  @impl true
  def handle_event("swing_west", _params, socket) do
    {:noreply, assign(socket, :stand, "west")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 02 · Tobruk update desk
      </p>

      <h1>Tobruk update desk</h1>
      <p class="lede">
        Clerk {@clerk} swings the {@craft} stand. The cell sees the new stand
        through update/2.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="swing-west" type="button" phx-click="swing_west">
        Swing west
      </button>

      <.live_component module={TobrukUpdateCell} id="update-cell" stand={@stand} />
    </Layouts.catalog>
    """
  end
end
