defmodule PhoenixMultivitaminWeb.ColmanDockShedHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 07 · Colman Dock shed
      </p>

      <h1>Colman Dock shed</h1>
      <p id="admitted-banner" class="mount-banner">
        Agent {@agent} admits {@passenger} through the {@turnstile} for {@slip}.
      </p>

      <.trace trace={@pipeline_trace} />

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/07-colman-dock-shed"}>Pier map</.link>
      </p>
    </Layouts.catalog>
    """
  end

  def denied(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 07 · Colman Dock shed
      </p>

      <h1>Colman Dock shed</h1>
      <p id="denied-banner" class="mount-banner static-mount">
        No walk-on pass. Agent {@agent} holds the turnstile at {@dock}. The
        later plug never stamps, and show/2 never runs.
      </p>

      <.trace trace={@pipeline_trace} />

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/07-colman-dock-shed"}>Pier map</.link>
      </p>
    </Layouts.catalog>
    """
  end

  defp trace(assigns) do
    ~H"""
    <div class="scenario">
      <h2>Plug order</h2>
      <ol id="pipeline-trace">
        <li :for={step <- @trace} id={"trace-#{step}"}>{step}</li>
      </ol>
    </div>
    """
  end
end
