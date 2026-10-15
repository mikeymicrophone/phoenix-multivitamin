# Function components and HEEx · 11 · Elwha hatchery trays
#
# Teaches:
# - values: is compile-time for literals; a dynamic assign is not rejected
# - LiveView does not raise at runtime for a species outside the list
# - A missing required attr on a direct call is a KeyError from @species,
#   not an ArgumentError from attr/3

defmodule PhoenixMultivitaminWeb.ElwhaHatcheryTraysLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Elwha hatchery trays")
     |> assign(:hatchery, "Lower Elwha Hatchery")
     |> assign(:culturist, "Leni")
     |> assign(:species, :chinook)
     |> assign(:pond, "A-3")}
  end

  @impl true
  def handle_event("load_chum", _params, socket) do
    {:noreply, assign(socket, :species, :chum)}
  end

  def handle_event("load_coho", _params, socket) do
    {:noreply, assign(socket, :species, :coho)}
  end

  attr :species, :atom, required: true, values: [:chinook, :coho, :steelhead]
  attr :pond, :string, required: true
  attr :id, :string, required: true
  attr :eggs, :integer, default: 4_800

  def incubation_tray(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>{species_line(@species)}</h2>
      <dl class="station-meta">
        <dt>Pond</dt>
        <dd data-field="pond">{@pond}</dd>
        <dt>Eggs</dt>
        <dd data-field="eggs">{@eggs}</dd>
        <dt>Species atom</dt>
        <dd data-field="species">{inspect(@species)}</dd>
      </dl>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 11 · Elwha hatchery trays
      </p>

      <h1>Elwha hatchery trays</h1>
      <p class="lede">
        {@culturist} loads Heath trays at {@hatchery}. <code>values:</code>
        lists chinook, coho, and steelhead. A chum load is a dynamic assign,
        not a literal, so the tray still prints.
      </p>

      <div class="watch-actions">
        <button id="load-chum" type="button" phx-click="load_chum">Load chum</button>
        <button id="load-coho" type="button" phx-click="load_coho">Load coho</button>
      </div>

      <.incubation_tray id="heath-tray" species={@species} pond={@pond} />
    </Layouts.catalog>
    """
  end

  defp species_line(:chinook), do: "Elwha chinook"
  defp species_line(:coho), do: "Elwha coho"
  defp species_line(:steelhead), do: "Elwha steelhead"
  defp species_line(other), do: "unlisted #{other}"
end
