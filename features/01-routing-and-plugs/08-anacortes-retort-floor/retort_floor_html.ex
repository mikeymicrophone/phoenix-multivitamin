defmodule PhoenixMultivitaminWeb.AnacortesRetortFloorHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def index(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 08 · Anacortes retort floor
      </p>

      <h1>Anacortes retort floor</h1>
      <p class="lede">
        Floor boss {@floor_boss} posts cooks at {@cannery}. This board is the
        browser pipeline. The same actions also speak JSON under <code>/api/cooks</code>.
      </p>

      <div class="scenario">
        <h2>Today's cooks</h2>
        <ul id="cook-list" class="watch-log">
          <li :for={cook <- @cooks} id={"cook-#{cook.id}"}>
            <.link href={
              ~p"/features/01-routing-and-plugs/08-anacortes-retort-floor/floor/cooks/#{cook.id}"
            }>
              {cook.kettle} · {cook.pack}
            </.link>
          </li>
        </ul>
      </div>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/08-anacortes-retort-floor"}>
          Cannery map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 08 · Anacortes retort floor
      </p>

      <h1>Anacortes retort floor</h1>
      <dl class="station-meta">
        <dt>Cannery</dt>
        <dd id="cannery-name">{@cannery}</dd>
        <dt>Kettle</dt>
        <dd id="kettle-name">{@cook.kettle}</dd>
        <dt>Pack</dt>
        <dd id="pack-name">{@cook.pack}</dd>
        <dt>Minutes</dt>
        <dd id="cook-minutes">{@cook.minutes}</dd>
      </dl>
    </Layouts.catalog>
    """
  end
end
