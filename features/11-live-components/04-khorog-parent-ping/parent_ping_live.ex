# LiveComponents · 04 · Khorog parent ping
#
# Teaches:
# - send/2 from child to parent

defmodule PhoenixMultivitaminWeb.KhorogParentPingLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.KhorogPingCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Khorog parent ping")
     |> assign(:clerk, "Faridun")
     |> assign(:craft, "PZL M-28")
     |> assign(:ridge, "quiet")}
  end

  @impl true
  def handle_info({:khorog_ping, ridge}, socket) do
    {:noreply, assign(socket, :ridge, ridge)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 04 · Khorog parent ping
      </p>

      <h1>Khorog parent ping</h1>
      <p class="lede">
        Clerk {@clerk} pings the parent from the {@craft} cell. The ridge
        lands on the LiveView.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="ridge-name">{@ridge}</p>

      <.live_component module={KhorogPingCell} id="ping-cell" />
    </Layouts.catalog>
    """
  end
end
