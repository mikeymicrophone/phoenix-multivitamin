defmodule PhoenixMultivitaminWeb.CapeFlatteryWatchHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def index(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Cape Flattery pipeline
      </p>

      <h1>Cape Flattery pipeline</h1>
      <p class="lede">
        Keeper {@keeper}'s watches on the {@lookout}. Nested <code>resources</code>
        under <code>/keepers/:keeper</code>.
      </p>

      <dl class="station-meta">
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Keeper is a string</dt>
        <dd id="keeper-binary">{if @keeper_is_binary, do: "yes", else: "no"}</dd>
        <dt>Cape</dt>
        <dd id="cape-name">{@cape}</dd>
      </dl>

      <ul id="watch-list" class="watch-log">
        <li :for={watch <- @watches} id={"watch-#{watch.id}"}>
          <a href={"/features/01-routing-and-plugs/13-cape-flattery-pipeline/lookout/keepers/#{@keeper}/watches/#{watch.id}"}>
            {watch.id} · {watch.window} · {watch.glass}
          </a>
        </li>
      </ul>
    </Layouts.catalog>
    """
  end

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Cape Flattery pipeline
      </p>

      <h1>Cape Flattery pipeline</h1>
      <dl class="station-meta">
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Watch id</dt>
        <dd id="watch-id">{@watch_id}</dd>
        <dt>Watch id is a string</dt>
        <dd id="watch-id-binary">{if @watch_id_is_binary, do: "yes", else: "no"}</dd>
        <dt>Window</dt>
        <dd id="watch-window">{@watch.window}</dd>
        <dt>Glass</dt>
        <dd id="watch-glass">{@watch.glass}</dd>
      </dl>
    </Layouts.catalog>
    """
  end
end
