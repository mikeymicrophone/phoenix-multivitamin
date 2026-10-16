# Core components and layouts · 02 · Guadalajara fuel flash
#
# Teaches:
# - put_flash/3 is rendered by flash_group in the layout, not the page body
# - The page never calls flash_group itself

defmodule PhoenixMultivitaminWeb.GuadalajaraFuelFlashLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Guadalajara fuel flash")
     |> assign(:bowser, "Luz")
     |> assign(:fuel, "Jet A-1")}
  end

  @impl true
  def handle_event("post_bowser", _params, socket) do
    {:noreply, put_flash(socket, :info, "Luz posted Jet A-1 on stand 12")}
  end

  def handle_event("spill_bowser", _params, socket) do
    {:noreply, put_flash(socket, :error, "Jet A-1 spill on the hydrant pit")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 02 · Guadalajara fuel flash
      </p>

      <h1>Guadalajara fuel flash</h1>
      <p class="lede">
        Bowser {@bowser} posts {@fuel} at Miguel Hidalgo. The flash lives in the
        layout. This page only puts it.
      </p>

      <div class="watch-switcher">
        <button id="post-bowser" type="button" phx-click="post_bowser">Post the bowser</button>
        <button id="spill-bowser" type="button" phx-click="spill_bowser">Log a spill</button>
      </div>
    </Layouts.catalog>
    """
  end
end
