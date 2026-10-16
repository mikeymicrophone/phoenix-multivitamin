defmodule PhoenixMultivitaminWeb.FinkenwerderJigFloorHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def index(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 08 · Finkenwerder jig floor
      </p>

      <h1>Finkenwerder jig floor</h1>
      <p class="lede">
        Jig clerk {@jig_clerk} posts joins at {@plant}. This board is the
        browser pipeline. The same actions also speak JSON under <code>/api/jigs</code>.
      </p>

      <div class="scenario">
        <h2>Today's jigs</h2>
        <ul id="jig-list" class="watch-log">
          <li :for={jig <- @jigs} id={"jig-#{jig.id}"}>
            <.link href={
              ~p"/features/01-routing-and-plugs/08-finkenwerder-jig-floor/floor/jigs/#{jig.id}"
            }>
              {jig.station} · {jig.join}
            </.link>
          </li>
        </ul>
      </div>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/08-finkenwerder-jig-floor"}>
          Plant map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 08 · Finkenwerder jig floor
      </p>

      <h1>Finkenwerder jig floor</h1>
      <dl class="station-meta">
        <dt>Plant</dt>
        <dd id="plant-name">{@plant}</dd>
        <dt>Station</dt>
        <dd id="station-name">{@jig.station}</dd>
        <dt>Join</dt>
        <dd id="join-name">{@jig.join}</dd>
        <dt>Minutes</dt>
        <dd id="jig-minutes">{@jig.minutes}</dd>
      </dl>
    </Layouts.catalog>
    """
  end
end
