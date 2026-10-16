defmodule PhoenixMultivitaminWeb.UshuaiaAustralPipelineHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def austral(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Ushuaia austral pipeline
      </p>

      <h1>Ushuaia austral pipeline</h1>
      <p class="lede">
        Clerk {@clerk} stands {@austral} on {@nation} land. This outer board
        is the austral pipeline only. The lookout is forwarded behind a ticket.
      </p>

      <dl class="station-meta">
        <dt>Austral</dt>
        <dd id="austral-name">{@austral}</dd>
        <dt>Nation</dt>
        <dd id="nation-name">{@nation}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
      </dl>

      <ol id="pipeline-trace">
        <li :for={step <- @pipeline_trace} id={"trace-#{step}"}>{step}</li>
      </ol>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/13-ushuaia-austral-pipeline"}>
          Headland map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
