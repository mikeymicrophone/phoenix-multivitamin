# LiveComponents · 05 · Coyhaique brief cell
#
# Teaches:
# - send(self(), ...) from parent to a component via update

defmodule PhoenixMultivitaminWeb.CoyhaiqueBriefCellLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.CoyhaiqueBriefCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Coyhaique brief cell")
     |> assign(:clerk, "Ximena")
     |> assign(:craft, "Cessna 337 Skymaster")
     |> assign(:brief, "pending")}
  end

  @impl true
  def handle_event("fetch_brief", _params, socket) do
    send(self(), :andes_brief)
    {:noreply, socket}
  end

  @impl true
  def handle_info(:andes_brief, socket) do
    {:noreply, assign(socket, :brief, "wave over the Simpson")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 05 · Coyhaique brief cell
      </p>

      <h1>Coyhaique brief cell</h1>
      <p class="lede">
        Clerk {@clerk} fetches an Andes brief for the {@craft}. The parent
        sends itself a message, then update/2 fills the cell.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="fetch-brief" type="button" phx-click="fetch_brief">
        Fetch brief
      </button>

      <.live_component module={CoyhaiqueBriefCell} id="brief-cell" brief={@brief} />
    </Layouts.catalog>
    """
  end
end
