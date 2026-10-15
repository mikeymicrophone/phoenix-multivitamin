defmodule PhoenixMultivitaminWeb.QuillayuteChartDeskHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def roster(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 11 · Quillayute chart desk
      </p>

      <h1>Quillayute chart desk</h1>
      <p id="roster-banner" class="mount-banner static-mount">
        Sign the roster at {@station} before the bar charts come out of the
        drawer. Officer Wren is on tonight.
      </p>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/11-quillayute-chart-desk"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end

  def desk(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 11 · Quillayute chart desk
      </p>

      <h1>Quillayute chart desk</h1>
      <p id="desk-banner" class="mount-banner">
        Officer {@officer} spreads {@chart} on the desk at {@station}.
      </p>

      <dl class="station-meta">
        <dt>Officer</dt>
        <dd id="officer-name">{@officer}</dd>
        <dt>Chart</dt>
        <dd id="chart-name">{@chart}</dd>
        <dt>Charts opened</dt>
        <dd id="charts-opened">{if @charts_opened, do: "yes", else: "no"}</dd>
      </dl>
    </Layouts.catalog>
    """
  end
end
