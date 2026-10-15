defmodule PhoenixMultivitaminWeb.BallardLockHouseHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 10 · Ballard lock house
      </p>

      <h1>Ballard lock house</h1>
      <p class="lede">
        Keeper {@keeper} works {@chambers} chambers at {@lock} on the {@cut}.
        The chamber count was an <code>init/1</code> option, captured when this
        controller compiled.
      </p>

      <dl class="station-meta">
        <dt>Lock</dt>
        <dd id="lock-name">{@lock}</dd>
        <dt>Chambers</dt>
        <dd id="chamber-count">{@chambers}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Compiled at</dt>
        <dd id="plug-compiled-at">{@plug_compiled_at}</dd>
        <dt>Called at</dt>
        <dd id="plug-called-at">{@plug_called_at}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/10-ballard-lock-house"}>Canal map</.link>
      </p>
    </Layouts.catalog>
    """
  end
end
