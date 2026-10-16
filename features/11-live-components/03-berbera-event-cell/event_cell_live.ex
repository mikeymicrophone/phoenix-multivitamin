# LiveComponents · 03 · Berbera event cell
#
# Teaches:
# - handle_event/3 in the component, not the parent

defmodule PhoenixMultivitaminWeb.BerberaEventCellLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.BerberaEventCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Berbera event cell")
     |> assign(:clerk, "Hodan")
     |> assign(:craft, "Shorts 330")
     |> assign(:parent_stand, "quiet")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 03 · Berbera event cell
      </p>

      <h1>Berbera event cell</h1>
      <p class="lede">
        Clerk {@clerk} parks the {@craft} inside the cell. The parent never
        hears the click.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="parent-stand">{@parent_stand}</p>

      <.live_component module={BerberaEventCell} id="event-cell" />
    </Layouts.catalog>
    """
  end
end
