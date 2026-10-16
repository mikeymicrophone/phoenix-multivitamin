# Core components and layouts · 01 · Duxford hangar board
#
# Teaches:
# - Layouts.catalog is the vitamin-bottle chrome
# - Layouts.app is the generator app layout
# - live_action picks which layout wraps the same LiveView

defmodule PhoenixMultivitaminWeb.DuxfordHangarBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Duxford hangar board")
     |> assign(:curator, "Gwendolen")
     |> assign(:craft, "Hawker Hurricane")}
  end

  @impl true
  def render(%{live_action: :app} = assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <p id="app-surface">App layout</p>
      <h1>Duxford hangar board</h1>
      <p class="lede">
        Curator {@curator} hangs the {@craft} under the generator app chrome.
        The root layout still owns the HTML shell.
      </p>
      <.link
        id="back-catalog-hangar"
        navigate={~p"/features/05-core-components-and-layouts/01-duxford-hangar-board"}
      >
        Back to the catalog card
      </.link>
    </Layouts.app>
    """
  end

  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 01 · Duxford hangar board
      </p>

      <h1>Duxford hangar board</h1>
      <p class="lede">
        Curator {@curator} keeps the {@craft} card in the vitamin-bottle layout.
        The hangar path wraps the same LiveView in <code>Layouts.app</code>.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-app-hangar"
          href={~p"/features/05-core-components-and-layouts/01-duxford-hangar-board/hangar"}
        >
          Open the app-layout hangar
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
