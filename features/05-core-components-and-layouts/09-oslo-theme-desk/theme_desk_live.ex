# Core components and layouts · 09 · Oslo theme desk
#
# Teaches:
# - The theme toggle sits in the layout, not the page
# - The page does not render a second toggle

defmodule PhoenixMultivitaminWeb.OsloThemeDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Oslo theme desk")
     |> assign(:controller_name, "Ingrid")
     |> assign(:craft, "Boeing 737 MAX 8")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Core components and layouts · 09 · Oslo theme desk
      </p>

      <h1>Oslo theme desk</h1>
      <p class="lede">
        Controller {@controller_name} keeps the {@craft} night desk at Gardermoen.
        Light and dark live in the layout header. This page has no toggle of its own.
      </p>

      <p id="controller-name">{@controller_name}</p>
      <p id="desk-surface">night desk</p>
    </Layouts.catalog>
    """
  end
end
