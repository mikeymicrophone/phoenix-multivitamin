defmodule PhoenixMultivitaminWeb.KalamaElevatorTapeHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 06 · Kalama elevator tape
      </p>

      <h1>Kalama elevator tape</h1>
      <p class="lede">
        Operator {@operator} reads the tape at {@silo} on the {@river}. The
        pipeline plug already assigned the shift onto this conn. The controller
        did not have to copy it.
      </p>

      <dl class="station-meta">
        <dt>Silo</dt>
        <dd id="silo-name">{@silo}</dd>
        <dt>Shift</dt>
        <dd id="shift-name">{@shift}</dd>
        <dt>Operator</dt>
        <dd id="operator-name">{@operator}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/06-kalama-elevator-tape"}>
          River map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
