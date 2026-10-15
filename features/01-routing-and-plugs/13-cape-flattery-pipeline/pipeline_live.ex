# Routing and plugs · 13 · Cape Flattery pipeline
#
# Teaches:
# - Capstone: outer pipeline, forward, halt, nested scopes, and resources
# - A specific route declared before resources wins over :id

defmodule PhoenixMultivitaminWeb.CapeFlatteryPipelineLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Cape Flattery pipeline")
     |> assign(:cape, "Cape Flattery")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Cape Flattery pipeline
      </p>

      <h1>Cape Flattery pipeline</h1>
      <p class="lede">
        {@cape} is the outer pipeline. Tatoosh Island is forwarded behind
        ticket <code>tatoosh-clear</code>. Nessa's watches are nested
        resources; the fog glass is a more specific route declared first.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-cape"
          href={~p"/features/01-routing-and-plugs/13-cape-flattery-pipeline/cape"}
        >
          Cape board
        </.link>
        <a
          id="open-lookout"
          href="/features/01-routing-and-plugs/13-cape-flattery-pipeline/lookout"
        >
          Tatoosh lookout
        </a>
      </div>
    </Layouts.catalog>
    """
  end
end
