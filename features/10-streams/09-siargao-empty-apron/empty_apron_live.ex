# Streams · 09 · Siargao empty apron
#
# Teaches:
# - Empty state when the stream has no rows

defmodule PhoenixMultivitaminWeb.SiargaoEmptyApronLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Siargao empty apron")
     |> assign(:clerk, "Ligaya")
     |> assign(:craft, "Quest Kodiak 100")
     |> stream(:stands, [])}
  end

  @impl true
  def handle_event("park_cloud", _params, socket) do
    {:noreply, stream_insert(socket, :stands, %{id: "cloud9", name: "Cloud 9"})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 09 · Siargao empty apron
      </p>

      <h1>Siargao empty apron</h1>
      <p class="lede">
        Clerk {@clerk} opens an empty {@craft} apron at Siargao until Cloud 9 parks.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="park-cloud" type="button" phx-click="park_cloud">
        Park Cloud 9
      </button>

      <div id="stands" phx-update="stream">
        <p class="hidden only:block" id="empty-apron">Apron is empty.</p>
        <p :for={{id, stand} <- @streams.stands} id={id}>{stand.name}</p>
      </div>
    </Layouts.catalog>
    """
  end
end
