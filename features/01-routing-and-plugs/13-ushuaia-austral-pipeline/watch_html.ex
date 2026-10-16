defmodule PhoenixMultivitaminWeb.UshuaiaWatchHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def index(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Ushuaia austral pipeline
      </p>

      <h1>Ushuaia austral pipeline</h1>
      <p class="lede">
        Clerk {@clerk}'s watches on the {@lookout}. Nested <code>resources</code>
        under <code>/clerks/:clerk</code>.
      </p>

      <dl class="station-meta">
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
        <dt>Clerk is a string</dt>
        <dd id="clerk-binary">{if @clerk_is_binary, do: "yes", else: "no"}</dd>
        <dt>Austral</dt>
        <dd id="austral-name">{@austral}</dd>
      </dl>

      <ul id="watch-list" class="watch-log">
        <li :for={watch <- @watches} id={"watch-#{watch.id}"}>
          <a href={"/features/01-routing-and-plugs/13-ushuaia-austral-pipeline/lookout/clerks/#{@clerk}/watches/#{watch.id}"}>
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
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 13 · Ushuaia austral pipeline
      </p>

      <h1>Ushuaia austral pipeline</h1>
      <dl class="station-meta">
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
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
