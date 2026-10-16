# Function components and HEEx · 11 · Linköping Gripen trays
#
# Teaches:
# - values: is compile-time for literals; a dynamic assign is not rejected
# - LiveView does not raise at runtime for a mark outside the list
# - A missing required attr on a direct call is a KeyError from @mark,
#   not an ArgumentError from attr/3

defmodule PhoenixMultivitaminWeb.LinkopingGripenTraysLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Linköping Gripen trays")
     |> assign(:plant, "Saab · Linköping")
     |> assign(:inspector, "Liv")
     |> assign(:mark, :c)
     |> assign(:bay, "A-3")}
  end

  @impl true
  def handle_event("load_naval", _params, socket) do
    {:noreply, assign(socket, :mark, :naval)}
  end

  def handle_event("load_d", _params, socket) do
    {:noreply, assign(socket, :mark, :d)}
  end

  attr :mark, :atom, required: true, values: [:c, :d, :e]
  attr :bay, :string, required: true
  attr :id, :string, required: true
  attr :rivets, :integer, default: 4_800

  def mark_tray(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>{mark_line(@mark)}</h2>
      <dl class="station-meta">
        <dt>Bay</dt>
        <dd data-field="bay">{@bay}</dd>
        <dt>Rivets</dt>
        <dd data-field="rivets">{@rivets}</dd>
        <dt>Mark atom</dt>
        <dd data-field="mark">{inspect(@mark)}</dd>
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
        · Function components and HEEx · 11 · Linköping Gripen trays
      </p>

      <h1>Linköping Gripen trays</h1>
      <p class="lede">
        {@inspector} inspects JAS 39 Gripen trays at {@plant}. <code>values:</code>
        lists marks C, D, and E. A naval load is a dynamic assign,
        not a literal, so the tray still prints.
      </p>

      <div class="watch-actions">
        <button id="load-naval" type="button" phx-click="load_naval">Load naval</button>
        <button id="load-d" type="button" phx-click="load_d">Load mark D</button>
      </div>

      <.mark_tray id="gripen-tray" mark={@mark} bay={@bay} />
    </Layouts.catalog>
    """
  end

  defp mark_line(:c), do: "Gripen mark C"
  defp mark_line(:d), do: "Gripen mark D"
  defp mark_line(:e), do: "Gripen mark E"
  defp mark_line(other), do: "unlisted #{other}"
end
