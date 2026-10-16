defmodule PhoenixMultivitaminWeb.LuklaShearGateHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 01 · Lukla shear gate
      </p>

      <h1>Lukla shear gate</h1>
      <p class="lede">
        Controller {@controller_name} reads the gate at {@gate}. The router pipeline stamps
        the Khumbu approach; the controller function plugs stamp the shear window and the
        request method before this board is drawn.
      </p>

      <dl class="station-meta">
        <dt>Approach</dt>
        <dd id="approach-name">{@approach}</dd>
        <dt>Gate</dt>
        <dd id="gate-name">{@gate}</dd>
        <dt>Window</dt>
        <dd id="shear-window">{@shear_window}</dd>
        <dt>Controller</dt>
        <dd id="controller-name">{@controller_name}</dd>
        <dt>Method</dt>
        <dd id="request-method">{@request_method}</dd>
      </dl>

      <div class="scenario">
        <h2>Plug order</h2>
        <ol id="pipeline-trace">
          <li :for={step <- @pipeline_trace} id={"trace-#{step}"}>{step}</li>
        </ol>
      </div>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/01-lukla-shear-gate"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
