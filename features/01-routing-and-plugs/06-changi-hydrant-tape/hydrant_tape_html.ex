defmodule PhoenixMultivitaminWeb.ChangiHydrantTapeHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 06 · Changi hydrant tape
      </p>

      <h1>Changi hydrant tape</h1>
      <p class="lede">
        Operator {@operator} reads the tape at {@hydrant} on {@apron}. The
        pipeline plug already assigned the shift onto this conn. The controller
        did not have to copy it.
      </p>

      <dl class="station-meta">
        <dt>Hydrant</dt>
        <dd id="hydrant-name">{@hydrant}</dd>
        <dt>Shift</dt>
        <dd id="shift-name">{@shift}</dd>
        <dt>Operator</dt>
        <dd id="operator-name">{@operator}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/06-changi-hydrant-tape"}>
          Apron map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
