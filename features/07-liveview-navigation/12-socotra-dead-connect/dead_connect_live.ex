# LiveView navigation · 12 · Socotra dead connect
#
# Teaches:
# - A get of the destination is the dead render
# - live/2 then connects the same path

defmodule PhoenixMultivitaminWeb.SocotraDeadConnectLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Socotra dead connect")
     |> assign(:clerk, "Nadir")
     |> assign(:craft, "Antonov An-26")
     |> assign(:connected_mount?, connected?(socket))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 12 · Socotra dead connect
      </p>

      <h1>Socotra dead connect</h1>
      <p class="lede">
        Clerk {@clerk} opens the {@craft} threshold. The first paint is a
        dead render. The socket then connects.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="mount-banner">
        <%= if @connected_mount? do %>
          Socket connected on the Socotra threshold.
        <% else %>
          Dead render of the Socotra threshold.
        <% end %>
      </p>
    </Layouts.catalog>
    """
  end
end
