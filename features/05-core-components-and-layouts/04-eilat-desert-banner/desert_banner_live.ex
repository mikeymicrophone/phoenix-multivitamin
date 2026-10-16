# Core components and layouts · 04 · Eilat desert banner
#
# Teaches:
# - Overriding a core input class replaces the defaults; they are not merged

defmodule PhoenixMultivitaminWeb.EilatDesertBannerLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Eilat desert banner")
     |> assign(:marshal, "Noa")
     |> assign(:craft, "King Air 350")
     |> assign(:qnh, "1011")}
  end

  @impl true
  def handle_event("stamp_qnh", %{"qnh" => qnh}, socket) do
    {:noreply, assign(socket, :qnh, qnh)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 04 · Eilat desert banner
      </p>

      <h1>Eilat desert banner</h1>
      <p class="lede">
        Marshal {@marshal} stamps QNH for a {@craft} at Ramon. The QNH field
        passes its own class, so the default <code>w-full input</code> is gone.
      </p>

      <form id="qnh-form" phx-change="stamp_qnh">
        <.input
          id="qnh-field"
          name="qnh"
          label="QNH"
          value={@qnh}
          class="w-full rounded-none border-4 border-amber-600 bg-amber-50 px-3 py-2 text-amber-950"
        />
      </form>

      <p id="posted-qnh">{@qnh}</p>
    </Layouts.catalog>
    """
  end
end
