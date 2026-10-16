# Routing and plugs · 13 · Ushuaia austral pipeline
#
# Teaches:
# - Capstone: outer pipeline, forward, halt, nested scopes, and resources
# - A specific route declared before resources wins over :id

defmodule PhoenixMultivitaminWeb.UshuaiaAustralPipelineLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Ushuaia austral pipeline")
     |> assign(:austral, "Ushuaia austral")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Ushuaia austral pipeline
      </p>

      <h1>Ushuaia austral pipeline</h1>
      <p class="lede">
        {@austral} is the outer pipeline. Martial glacier is forwarded behind
        ticket <code>austral-clear</code>. Pilar's watches are nested
        resources; the icing glass is a more specific route declared first.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-austral"
          href={~p"/features/01-routing-and-plugs/13-ushuaia-austral-pipeline/austral"}
        >
          Austral board
        </.link>
        <a
          id="open-lookout"
          href="/features/01-routing-and-plugs/13-ushuaia-austral-pipeline/lookout"
        >
          Martial lookout
        </a>
      </div>
    </Layouts.catalog>
    """
  end
end
