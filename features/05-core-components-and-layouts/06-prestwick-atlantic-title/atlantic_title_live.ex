# Core components and layouts · 06 · Prestwick Atlantic title
#
# Teaches:
# - live_title in the root layout owns the suffix
# - page_title is only the prefix the LiveView assigns

defmodule PhoenixMultivitaminWeb.PrestwickAtlanticTitleLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Prestwick Atlantic title")
     |> assign(:clerk, "Mhairi")
     |> assign(:craft, "Airbus A380")}
  end

  @impl true
  def handle_event("retitle_crossing", _params, socket) do
    {:noreply, assign(socket, :page_title, "Prestwick A380 crossing")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 06 · Prestwick Atlantic title
      </p>

      <h1>Prestwick Atlantic title</h1>
      <p class="lede">
        Clerk {@clerk} titles the {@craft} transatlantic crossing at Prestwick.
        The root layout appends <code>· Phoenix</code>. This page only sets <code>page_title</code>.
      </p>

      <button id="retitle-crossing" type="button" phx-click="retitle_crossing">
        Retitle the crossing
      </button>
    </Layouts.catalog>
    """
  end
end
