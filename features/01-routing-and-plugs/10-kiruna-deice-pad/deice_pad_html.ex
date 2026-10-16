defmodule PhoenixMultivitaminWeb.KirunaDeicePadHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 10 · Kiruna de-ice pad
      </p>

      <h1>Kiruna de-ice pad</h1>
      <p class="lede">
        Pad lead {@pad_lead} works {@pads} pads at {@pad} on the {@apron}.
        The pad count is an <code>init/1</code>
        option. In mix test, <code>plug_init_mode</code>
        is <code>:runtime</code>, so init runs
        again on the next spray.
      </p>

      <dl class="station-meta">
        <dt>Pad</dt>
        <dd id="pad-name">{@pad}</dd>
        <dt>Pads</dt>
        <dd id="pad-count">{@pads}</dd>
        <dt>Pad lead</dt>
        <dd id="pad-lead-name">{@pad_lead}</dd>
        <dt>Compiled at</dt>
        <dd id="plug-compiled-at">{@plug_compiled_at}</dd>
        <dt>Called at</dt>
        <dd id="plug-called-at">{@plug_called_at}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/10-kiruna-deice-pad"}>Apron map</.link>
      </p>
    </Layouts.catalog>
    """
  end
end
