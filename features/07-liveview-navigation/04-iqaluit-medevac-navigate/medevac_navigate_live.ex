# LiveView navigation · 04 · Iqaluit medevac navigate
#
# Teaches:
# - <.link navigate={~p}> is the HEEx live_redirect
# - The hold board is a different path and a different LiveView

defmodule PhoenixMultivitaminWeb.IqaluitMedevacNavigateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Iqaluit medevac navigate")
     |> assign(:clerk, "Aput")
     |> assign(:craft, "Dash 8-300")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 04 · Iqaluit medevac navigate
      </p>

      <h1>Iqaluit medevac navigate</h1>
      <p class="lede">
        Clerk {@clerk} sends the {@craft} to the hold board with a <code>navigate</code> link.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="surface-name">pad</p>

      <.link
        id="open-hold"
        navigate={~p"/features/07-liveview-navigation/04-iqaluit-medevac-navigate/hold"}
      >
        Open hold
      </.link>
    </Layouts.catalog>
    """
  end
end
