# LiveComponents · 01 · Qaanaaq frost cell
#
# Teaches:
# - A stateful component with its own id

defmodule PhoenixMultivitaminWeb.QaanaaqFrostCellLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.QaanaaqFrostCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Qaanaaq frost cell")
     |> assign(:clerk, "Niviaq")
     |> assign(:craft, "DHC-3 Otter")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 01 · Qaanaaq frost cell
      </p>

      <h1>Qaanaaq frost cell</h1>
      <p class="lede">
        Clerk {@clerk} keeps frost taps for the {@craft} in a cell with its own id.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.live_component module={QaanaaqFrostCell} id="frost-cell" clerk={@clerk} craft={@craft} />
    </Layouts.catalog>
    """
  end
end
