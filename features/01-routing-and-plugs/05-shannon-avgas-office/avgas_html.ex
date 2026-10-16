defmodule PhoenixMultivitaminWeb.ShannonAvgasHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 05 · Shannon avgas office
      </p>

      <h1>Shannon avgas office</h1>
      <p class="lede">
        Clerk {@clerk} posts the 100LL load for {@bowser} at {@apron}. The
        apron, grade, and bowser name were keyword options on the controller
        plug. <code>init/1</code> turned them into a map before <code>call/2</code>.
      </p>

      <dl class="station-meta">
        <dt>Apron</dt>
        <dd id="apron-name">{@apron}</dd>
        <dt>Bowser</dt>
        <dd id="bowser-name">{@bowser}</dd>
        <dt>Grade</dt>
        <dd id="grade-name">{@grade}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
        <dt>Init keys</dt>
        <dd id="init-keys">{@init_keys}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/05-shannon-avgas-office"}>
          Apron map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
