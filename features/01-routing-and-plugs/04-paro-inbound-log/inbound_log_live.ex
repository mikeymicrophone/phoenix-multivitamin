# Routing and plugs · 04 · Paro inbound log
#
# Teaches:
# - forward/2 mounts another router under a prefix
# - The inner board is unaware of the catalog prefix

defmodule PhoenixMultivitaminWeb.ParoInboundLogLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Paro inbound log")
     |> assign(:station, "Paro")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 04 · Paro inbound log
      </p>

      <h1>Paro inbound log</h1>
      <p class="lede">
        {@station} sits in a notch of the Himalaya. The
        inbound log is forwarded into its own router, so the inner routes
        are <code>/</code> and <code>/a319/:reg</code>.
      </p>

      <div class="watch-switcher">
        <a id="open-valley" href="/features/01-routing-and-plugs/04-paro-inbound-log/valley">
          Open the inbound log
        </a>
      </div>
    </Layouts.catalog>
    """
  end
end
