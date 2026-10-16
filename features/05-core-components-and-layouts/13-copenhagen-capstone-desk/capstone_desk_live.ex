# Core components and layouts · 13 · Copenhagen capstone desk
#
# Teaches:
# - Capstone: layout, flash, core table, and a modal on one desk

defmodule PhoenixMultivitaminWeb.CopenhagenCapstoneDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Copenhagen capstone desk")
     |> assign(:clerk, "Freja")
     |> assign(:show_hold, false)
     |> assign(:stands, [
       %{id: "a17", stand: "A17", craft: "Airbus A220-300", status: "boarding"},
       %{id: "b09", stand: "B09", craft: "Airbus A220-300", status: "empty"}
     ])}
  end

  @impl true
  def handle_event("open_hold", _params, socket) do
    {:noreply, assign(socket, :show_hold, true)}
  end

  def handle_event("close_hold", _params, socket) do
    {:noreply, assign(socket, :show_hold, false)}
  end

  def handle_event("confirm_hold", _params, socket) do
    {:noreply,
     socket
     |> assign(:show_hold, false)
     |> put_flash(:info, "Freja held A17 for the A220-300")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 13 · Copenhagen capstone desk
      </p>

      <h1>Copenhagen capstone desk</h1>
      <p class="lede">
        Clerk {@clerk} keeps the Kastrup stand desk. The catalog layout, a core
        table, a modal, and a flash share one board.
      </p>

      <.table id="kastrup-stands" rows={@stands} row_id={fn row -> row.id end}>
        <:col :let={row} label="Stand">{row.stand}</:col>
        <:col :let={row} label="Craft">{row.craft}</:col>
        <:col :let={row} label="Status">{row.status}</:col>
      </.table>

      <.button id="open-hold" phx-click="open_hold">Hold A17</.button>

      <.modal id="hold-modal" show={@show_hold} on_cancel={JS.push("close_hold")}>
        <:title>Hold A17</:title>
        Confirm the A220-300 stays on A17.
        <:confirm id="confirm-hold">
          <button type="button" phx-click="confirm_hold">Hold</button>
        </:confirm>
        <:cancel>Release</:cancel>
      </.modal>
    </Layouts.catalog>
    """
  end
end
