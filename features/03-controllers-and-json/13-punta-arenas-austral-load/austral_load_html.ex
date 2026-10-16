defmodule PhoenixMultivitaminWeb.PuntaArenasAustralLoadHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Controllers and JSON · 13 · Punta Arenas austral load
      </p>

      <h1>Punta Arenas austral load</h1>
      <p class="lede">
        Loadmaster {@load.loadmaster} staged the {@load.craft} for {@load.destination}.
      </p>

      <dl class="station-meta">
        <dt>Destination</dt>
        <dd id="load-destination">{@load.destination}</dd>
        <dt>Cargo</dt>
        <dd id="load-cargo">{@load.cargo}</dd>
        <dt>Kilograms</dt>
        <dd id="load-kg">{@load.kg}</dd>
        <dt>Loadmaster</dt>
        <dd id="load-master">{@load.loadmaster}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/03-controllers-and-json/13-punta-arenas-austral-load"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
