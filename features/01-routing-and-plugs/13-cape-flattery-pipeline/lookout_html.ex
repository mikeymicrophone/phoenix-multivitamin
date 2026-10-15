defmodule PhoenixMultivitaminWeb.CapeFlatteryLookoutHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def desk(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Cape Flattery pipeline
      </p>

      <h1>Cape Flattery pipeline</h1>
      <p id="desk-banner" class="mount-banner">
        Keeper {@keeper} is on the {@lookout} with ticket {@ticket}, talking {@radio_channel}.
      </p>

      <.cape_meta cape={@cape} nation={@nation} trace={@pipeline_trace} />

      <div class="watch-switcher">
        <a
          id="open-nessa-watches"
          href="/features/01-routing-and-plugs/13-cape-flattery-pipeline/lookout/keepers/nessa/watches"
        >
          Nessa's watches
        </a>
        <a
          id="open-fog"
          href="/features/01-routing-and-plugs/13-cape-flattery-pipeline/lookout/keepers/nessa/watches/fog"
        >
          Fog glass
        </a>
      </div>
    </Layouts.catalog>
    """
  end

  def fog(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Cape Flattery pipeline
      </p>

      <h1>Cape Flattery pipeline</h1>
      <p id="fog-banner" class="mount-banner">
        Keeper {@keeper} has the {@watch} glass on Tatoosh, a specific route
        declared before <code>resources</code>.
      </p>

      <.cape_meta cape={@cape} nation={@nation} trace={@pipeline_trace} />
    </Layouts.catalog>
    """
  end

  def denied(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Cape Flattery pipeline
      </p>

      <h1>Cape Flattery pipeline</h1>
      <p id="denied-banner" class="mount-banner static-mount">
        No Tatoosh ticket. The cape plug already stamped {@cape}. The lookout
        desk never opens.
      </p>

      <.cape_meta cape={@cape} nation={@nation} trace={@pipeline_trace} />
    </Layouts.catalog>
    """
  end

  defp cape_meta(assigns) do
    ~H"""
    <dl class="station-meta">
      <dt>Cape</dt>
      <dd id="cape-name">{@cape}</dd>
      <dt>Nation</dt>
      <dd id="nation-name">{@nation}</dd>
    </dl>
    <ol id="pipeline-trace">
      <li :for={step <- @trace} id={"trace-#{step}"}>{step}</li>
    </ol>
    """
  end
end
