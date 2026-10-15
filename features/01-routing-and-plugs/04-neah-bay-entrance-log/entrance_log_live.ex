# Routing and plugs · 04 · Neah Bay entrance log
#
# Teaches:
# - forward/2 mounts another router under a prefix
# - The inner board is unaware of the catalog prefix

defmodule PhoenixMultivitaminWeb.NeahBayEntranceLogLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Neah Bay entrance log")
     |> assign(:station, "Neah Bay")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 04 · Neah Bay entrance log
      </p>

      <h1>Neah Bay entrance log</h1>
      <p class="lede">
        {@station} sits at the mouth of the Strait of Juan de Fuca. The
        entrance log is forwarded into its own router, so the inner routes
        are <code>/</code> and <code>/canoe/:hull</code>.
      </p>

      <div class="watch-switcher">
        <a id="open-entrance" href="/features/01-routing-and-plugs/04-neah-bay-entrance-log/entrance">
          Open the entrance log
        </a>
      </div>
    </Layouts.catalog>
    """
  end
end
