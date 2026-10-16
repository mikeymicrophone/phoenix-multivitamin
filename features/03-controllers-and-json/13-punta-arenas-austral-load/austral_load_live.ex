# Controllers and JSON · 13 · Punta Arenas austral load
#
# Teaches:
# - Capstone: create, show, error fallback, and a JSON index together

defmodule PhoenixMultivitaminWeb.PuntaArenasAustralLoadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Punta Arenas austral load")
     |> assign(:station, "Carlos Ibáñez del Campo")
     |> assign(:person, "Cristóbal")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Controllers and JSON · 13 · Punta Arenas austral load
      </p>

      <h1>Punta Arenas austral load</h1>
      <p class="lede">
        Loadmaster {@person} stages a Lockheed C-130 toward Antarctica at {@station}.
        The desk lists JSON, shows a pallet, creates a valid load, and falls back
        on a short destination.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-loads"
          href={~p"/features/03-controllers-and-json/13-punta-arenas-austral-load/loads"}
        >
          List austral loads
        </.link>
        <.link
          id="open-teniente-load"
          href={~p"/features/03-controllers-and-json/13-punta-arenas-austral-load/loads/teniente"}
        >
          Open the Teniente pallet
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
