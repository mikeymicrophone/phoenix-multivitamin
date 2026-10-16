defmodule PhoenixMultivitaminWeb.UshuaiaLookoutHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def desk(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Ushuaia austral pipeline
      </p>

      <h1>Ushuaia austral pipeline</h1>
      <p id="desk-banner" class="mount-banner">
        Clerk {@clerk} is on the {@lookout} with ticket {@ticket}, talking {@radio_channel}.
      </p>

      <.austral_meta austral={@austral} nation={@nation} trace={@pipeline_trace} />

      <div class="watch-switcher">
        <a
          id="open-pilar-watches"
          href="/features/01-routing-and-plugs/13-ushuaia-austral-pipeline/lookout/clerks/pilar/watches"
        >
          Pilar's watches
        </a>
        <a
          id="open-icing"
          href="/features/01-routing-and-plugs/13-ushuaia-austral-pipeline/lookout/clerks/pilar/watches/icing"
        >
          Icing glass
        </a>
      </div>
    </Layouts.catalog>
    """
  end

  def icing(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Ushuaia austral pipeline
      </p>

      <h1>Ushuaia austral pipeline</h1>
      <p id="icing-banner" class="mount-banner">
        Clerk {@clerk} has the {@watch} glass on Martial, a specific route
        declared before <code>resources</code>.
      </p>

      <.austral_meta austral={@austral} nation={@nation} trace={@pipeline_trace} />
    </Layouts.catalog>
    """
  end

  def denied(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Ushuaia austral pipeline
      </p>

      <h1>Ushuaia austral pipeline</h1>
      <p id="denied-banner" class="mount-banner static-mount">
        No austral ticket. The austral plug already stamped {@austral}. The lookout
        desk never opens.
      </p>

      <.austral_meta austral={@austral} nation={@nation} trace={@pipeline_trace} />
    </Layouts.catalog>
    """
  end

  defp austral_meta(assigns) do
    ~H"""
    <dl class="station-meta">
      <dt>Austral</dt>
      <dd id="austral-name">{@austral}</dd>
      <dt>Nation</dt>
      <dd id="nation-name">{@nation}</dd>
    </dl>
    <ol id="pipeline-trace">
      <li :for={step <- @trace} id={"trace-#{step}"}>{step}</li>
    </ol>
    """
  end
end
