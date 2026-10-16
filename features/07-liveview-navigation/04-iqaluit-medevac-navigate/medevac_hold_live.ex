# LiveView navigation · 04 · Iqaluit medevac hold
#
# Teaches:
# - The hold is a second LiveView reached by a navigate link

defmodule PhoenixMultivitaminWeb.IqaluitMedevacHoldLive do
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
        Clerk {@clerk} holds the {@craft} on the medevac hold board.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="surface-name">hold</p>
    </Layouts.catalog>
    """
  end
end
