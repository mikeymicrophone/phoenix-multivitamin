# LiveComponents · 08 · Karaganda send update
#
# Teaches:
# - send_update/3 from the parent (update_component/3 is gone)

defmodule PhoenixMultivitaminWeb.KaragandaSendUpdateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.KaragandaQnhCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Karaganda send update")
     |> assign(:clerk, "Ayan")
     |> assign(:craft, "Yakovlev Yak-42")
     |> assign(:qnh, "1012")}
  end

  @impl true
  def handle_event("lift_qnh", _params, socket) do
    send_update(KaragandaQnhCell, id: "qnh-cell", qnh: "1024")
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 08 · Karaganda send update
      </p>

      <h1>Karaganda send update</h1>
      <p class="lede">
        Clerk {@clerk} lifts QNH on the {@craft} cell with send_update/3.
        The parent assign stays 1012.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="parent-qnh">{@qnh}</p>

      <button id="lift-qnh" type="button" phx-click="lift_qnh">Lift QNH</button>

      <.live_component module={KaragandaQnhCell} id="qnh-cell" qnh={@qnh} />
    </Layouts.catalog>
    """
  end
end
