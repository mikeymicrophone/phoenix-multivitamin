defmodule PhoenixMultivitaminWeb.BaltraBiosecurityPassHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 12 · Baltra biosecurity pass
      </p>

      <h1>Baltra biosecurity pass</h1>
      <p class="lede">
        Inspector {@pass.inspector} stamped a {@pass.kind} pass for the {@pass.craft}.
      </p>

      <dl class="station-meta">
        <dt>Kind</dt>
        <dd id="pass-kind">{@pass.kind}</dd>
        <dt>Boots</dt>
        <dd id="pass-boots">{@pass.boots}</dd>
        <dt>Fruit</dt>
        <dd id="pass-fruit">{@pass.fruit}</dd>
        <dt>Inspector</dt>
        <dd id="pass-inspector">{@pass.inspector}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/03-controllers-and-json/12-baltra-biosecurity-pass"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
