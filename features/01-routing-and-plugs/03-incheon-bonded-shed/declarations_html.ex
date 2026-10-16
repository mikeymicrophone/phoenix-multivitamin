defmodule PhoenixMultivitaminWeb.IncheonDeclarationsHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def index(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 03 · Incheon bonded shed
      </p>

      <h1>Incheon bonded shed</h1>
      <p class="lede">
        Inspector {@inspector} works the {@lane} lane at {@shed}. Sibling
        scopes share this controller; each pipes through its own inspector plug.
      </p>

      <dl class="station-meta">
        <dt>Shed</dt>
        <dd id="shed-name">{@shed}</dd>
        <dt>Lane</dt>
        <dd id="lane-name">{@lane}</dd>
        <dt>Inspector</dt>
        <dd id="inspector-name">{@inspector}</dd>
      </dl>

      <div class="scenario">
        <h2>Declarations</h2>
        <ul id="declaration-list" class="watch-log">
          <li :for={{id, declaration} <- @declarations} id={"declaration-#{id}"}>
            <.link href={declaration_href(@lane, id)}>
              {declaration.craft}
            </.link>
          </li>
        </ul>
      </div>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/03-incheon-bonded-shed"}>
          Shed map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 03 · Incheon bonded shed
      </p>

      <h1>Incheon bonded shed</h1>
      <p class="lede">
        Inspector {@inspector} posts {@declaration.craft} on the {@lane} lane.
      </p>

      <dl class="station-meta">
        <dt>Lane</dt>
        <dd id="lane-name">{@lane}</dd>
        <dt>Declaration id</dt>
        <dd id="declaration-id">{@declaration_id}</dd>
        <dt>Id is a string</dt>
        <dd id="declaration-id-binary">{if @declaration_id_is_binary, do: "yes", else: "no"}</dd>
        <dt>Craft</dt>
        <dd id="craft-name">{@declaration.craft}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link href={index_href(@lane)}>Back to the {@lane} ledger</.link>
      </p>
    </Layouts.catalog>
    """
  end

  defp declaration_href(:arrivals, id),
    do: ~p"/features/01-routing-and-plugs/03-incheon-bonded-shed/arrivals/declarations/#{id}"

  defp declaration_href(:departures, id),
    do: ~p"/features/01-routing-and-plugs/03-incheon-bonded-shed/departures/declarations/#{id}"

  defp index_href(:arrivals),
    do: ~p"/features/01-routing-and-plugs/03-incheon-bonded-shed/arrivals/declarations"

  defp index_href(:departures),
    do: ~p"/features/01-routing-and-plugs/03-incheon-bonded-shed/departures/declarations"
end
