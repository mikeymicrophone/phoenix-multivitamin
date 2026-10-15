# Routing and plugs · 07 · Colman Dock shed
#
# Teaches:
# - halt/1 in a controller plug skips later plugs and the action
# - Earlier plugs have already stamped the conn

defmodule PhoenixMultivitaminWeb.ColmanDockShedLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Colman Dock shed")
     |> assign(:dock, "Colman Dock")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 07 · Colman Dock shed
      </p>

      <h1>Colman Dock shed</h1>
      <p class="lede">
        Walk-ons for the Wenatchee at {@dock} need pass <code>wenatchee-walk-on</code>. Without it the turnstile plug never
        runs and the shed action never posts a slip.
      </p>

      <div class="watch-switcher">
        <.link id="open-shed" href={~p"/features/01-routing-and-plugs/07-colman-dock-shed/shed"}>
          Approach the shed
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
