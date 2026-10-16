# Core components and layouts · 08 · Kathmandu breadcrumb
#
# Teaches:
# - The page fills a layout breadcrumb slot
# - Shared layouts still mention no station name

defmodule PhoenixMultivitaminWeb.KathmanduBreadcrumbLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Kathmandu breadcrumb")
     |> assign(:dispatcher, "Bina")
     |> assign(:craft, "Harbin Y-12")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <PhoenixMultivitaminWeb.KathmanduBreadcrumbLayout.desk flash={@flash}>
      <:crumb>
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 08 · Kathmandu breadcrumb
      </:crumb>

      <h1>Kathmandu breadcrumb</h1>
      <p class="lede">
        Dispatcher {@dispatcher} walks a {@craft} onto the Tribhuvan bowl.
        The crumb is a layout slot. The shared catalog layout still names no station.
      </p>
      <p id="dispatcher-name">{@dispatcher}</p>
    </PhoenixMultivitaminWeb.KathmanduBreadcrumbLayout.desk>
    """
  end
end
