# Routing and plugs · 10 · Ballard lock house
#
# Teaches:
# - init/1 is captured at compile time; call/2 runs per lockage

defmodule PhoenixMultivitaminWeb.BallardLockHouseLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Ballard lock house")
     |> assign(:lock, "Hiram M. Chittenden Locks")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 10 · Ballard lock house
      </p>

      <h1>Ballard lock house</h1>
      <p class="lede">
        {@lock} lifts boats between Puget Sound and Lake Union. The chamber
        count is compiled into the plug; the call timestamp is not.
      </p>

      <div class="watch-switcher">
        <.link id="open-locks" href={~p"/features/01-routing-and-plugs/10-ballard-lock-house/locks"}>
          Open the lock house
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
