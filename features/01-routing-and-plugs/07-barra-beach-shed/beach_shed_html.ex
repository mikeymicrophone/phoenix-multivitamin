defmodule PhoenixMultivitaminWeb.BarraBeachShedHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 07 · Barra beach shed
      </p>

      <h1>Barra beach shed</h1>
      <p id="admitted-banner" class="mount-banner">
        Marshal {@marshal} admits {@passenger} through the {@turnstile} for {@slip}.
      </p>

      <.trace trace={@pipeline_trace} />

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/07-barra-beach-shed"}>Beach map</.link>
      </p>
    </Layouts.catalog>
    """
  end

  def denied(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 07 · Barra beach shed
      </p>

      <h1>Barra beach shed</h1>
      <p id="denied-banner" class="mount-banner static-mount">
        No beach pass. Marshal {@marshal} holds the turnstile at {@beach}. The
        later plug never stamps, and show/2 never runs.
      </p>

      <.trace trace={@pipeline_trace} />

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/07-barra-beach-shed"}>Beach map</.link>
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
