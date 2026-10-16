# LiveView navigation · 08 · Banjul hold stack
#
# Teaches:
# - push_navigate from the desk mounts this LiveView

defmodule PhoenixMultivitaminWeb.BanjulHoldStackLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Banjul hold navigate")
     |> assign(:clerk, "Fatou")
     |> assign(:craft, "CRJ200")
     |> assign(:ticks, 0)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 08 · Banjul hold navigate
      </p>

      <h1>Banjul hold navigate</h1>
      <p class="lede">
        Clerk {@clerk} holds the {@craft} in the Banjul stack. Fresh process.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="stack-ticks">{@ticks}</p>
      <p id="surface-name">stack</p>
    </Layouts.catalog>
    """
  end
end
