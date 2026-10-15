defmodule PhoenixMultivitaminWeb.WillapaSeedBargeHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 05 · Willapa seed barge office
      </p>

      <h1>Willapa seed barge office</h1>
      <p class="lede">
        Clerk {@clerk} posts the seed load for {@barge} at {@landing}. The
        landing, crop, and barge name were keyword options on the controller
        plug. <code>init/1</code> turned them into a map before <code>call/2</code>.
      </p>

      <dl class="station-meta">
        <dt>Landing</dt>
        <dd id="landing-name">{@landing}</dd>
        <dt>Barge</dt>
        <dd id="barge-name">{@barge}</dd>
        <dt>Crop</dt>
        <dd id="crop-name">{@crop}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
        <dt>Init keys</dt>
        <dd id="init-keys">{@init_keys}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/05-willapa-seed-barge-office"}>
          Tideflat map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
