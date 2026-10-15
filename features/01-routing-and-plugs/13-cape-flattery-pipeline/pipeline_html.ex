defmodule PhoenixMultivitaminWeb.CapeFlatteryPipelineHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def cape(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Cape Flattery pipeline
      </p>

      <h1>Cape Flattery pipeline</h1>
      <p class="lede">
        Keeper {@keeper} stands {@cape} on {@nation} land. This outer board
        is the cape pipeline only. The lookout is forwarded behind a ticket.
      </p>

      <dl class="station-meta">
        <dt>Cape</dt>
        <dd id="cape-name">{@cape}</dd>
        <dt>Nation</dt>
        <dd id="nation-name">{@nation}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
      </dl>

      <ol id="pipeline-trace">
        <li :for={step <- @pipeline_trace} id={"trace-#{step}"}>{step}</li>
      </ol>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/13-cape-flattery-pipeline"}>
          Headland map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
