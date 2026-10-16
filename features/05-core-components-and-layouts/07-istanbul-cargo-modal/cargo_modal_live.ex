# Core components and layouts · 07 · Istanbul cargo modal
#
# Teaches:
# - Modal, flash, and input from core_components on one desk

defmodule PhoenixMultivitaminWeb.IstanbulCargoModalLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Istanbul cargo modal")
     |> assign(:clerk, "Deniz")
     |> assign(:craft, "Boeing 747-400F")
     |> assign(:kg, "12000")
     |> assign(:show_hold, false)}
  end

  @impl true
  def handle_event("draft_kg", %{"kg" => kg}, socket) do
    {:noreply, assign(socket, :kg, kg)}
  end

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
     |> put_flash(:info, "Deniz held the 747-400F at #{socket.assigns.kg} kg")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 07 · Istanbul cargo modal
      </p>

      <h1>Istanbul cargo modal</h1>
      <p class="lede">
        Clerk {@clerk} weighs a {@craft} at Istanbul Airport. The kilograms field
        is a core input. Confirm is a core modal. The hold note is a layout flash.
      </p>

      <form id="kg-form" phx-change="draft_kg">
        <.input id="kg-field" name="kg" label="Kilograms" value={@kg} />
      </form>

      <.button id="open-hold" phx-click="open_hold">Open the hold modal</.button>

      <.modal id="hold-modal" show={@show_hold} on_cancel={JS.push("close_hold")}>
        <:title>Hold the 747-400F</:title>
        <:subtitle>Confirm {@kg} kg on the main deck.</:subtitle>
        Clerk {@clerk} will flash the hold through the layout.
        <:confirm id="confirm-hold">
          <button type="button" phx-click="confirm_hold">Hold</button>
        </:confirm>
        <:cancel id="cancel-hold">Keep loading</:cancel>
      </.modal>
    </Layouts.catalog>
    """
  end
end
