# Core components and layouts · 03 · Johannesburg QRA table
#
# Teaches:
# - Core table and button used as-is, with their default classes

defmodule PhoenixMultivitaminWeb.JohannesburgQraTableLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Johannesburg QRA table")
     |> assign(:clerk, "Thandi")
     |> assign(:scrambled, nil)
     |> assign(:pairs, [
       %{id: "oryx-1", craft: "Atlas Oryx", status: "armed", pad: "north"},
       %{id: "oryx-2", craft: "Atlas Oryx", status: "spare", pad: "south"}
     ])}
  end

  @impl true
  def handle_event("scramble_north", _params, socket) do
    {:noreply, assign(socket, :scrambled, "north")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 03 · Johannesburg QRA table
      </p>

      <h1>Johannesburg QRA table</h1>
      <p class="lede">
        Clerk {@clerk} keeps the Atlas Oryx quick-reaction table at AFB Waterkloof.
        The table and scramble button are core components with no extra class.
      </p>

      <.table id="qra-pairs" rows={@pairs} row_id={fn pair -> pair.id end}>
        <:col :let={pair} label="Craft">{pair.craft}</:col>
        <:col :let={pair} label="Status">{pair.status}</:col>
        <:col :let={pair} label="Pad">{pair.pad}</:col>
      </.table>

      <.button id="scramble-north" phx-click="scramble_north">Scramble north</.button>

      <p :if={@scrambled} id="scrambled-pad">{@scrambled}</p>
    </Layouts.catalog>
    """
  end
end
