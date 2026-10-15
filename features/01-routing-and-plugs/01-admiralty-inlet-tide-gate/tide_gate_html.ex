defmodule PhoenixMultivitaminWeb.AdmiraltyInletTideGateHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 01 · Admiralty Inlet tide gate
      </p>

      <h1>Admiralty Inlet tide gate</h1>
      <p class="lede">
        Keeper {@keeper} reads the gate at {@gate}. The router pipeline stamps
        the inlet; the controller function plugs stamp the flood window and the
        request method before this board is drawn.
      </p>

      <dl class="station-meta">
        <dt>Inlet</dt>
        <dd id="inlet-name">{@inlet}</dd>
        <dt>Gate</dt>
        <dd id="gate-name">{@gate}</dd>
        <dt>Window</dt>
        <dd id="gate-window">{@gate_window}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
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
        <.link navigate={~p"/features/01-routing-and-plugs/01-admiralty-inlet-tide-gate"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
