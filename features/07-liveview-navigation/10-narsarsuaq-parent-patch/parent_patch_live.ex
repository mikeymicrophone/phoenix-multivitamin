# LiveView navigation · 10 · Narsarsuaq parent patch
#
# Teaches:
# - A child pad path patches back to the parent board
# - The same LiveView handles both live_actions

defmodule PhoenixMultivitaminWeb.NarsarsuaqParentPatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Narsarsuaq parent patch")
     |> assign(:clerk, "Naja")
     |> assign(:craft, "Dash 7")
     |> assign(:mounts, 1)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    pad = Map.get(params, "pad")
    surface = if socket.assigns.live_action == :pad, do: :pad, else: :board

    {:noreply,
     socket
     |> assign(:pad, pad)
     |> assign(:surface, surface)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 10 · Narsarsuaq parent patch
      </p>

      <h1>Narsarsuaq parent patch</h1>
      <p class="lede">
        Clerk {@clerk} walks the {@craft} onto the east pad, then patches back
        to the parent board.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="surface-name">{@surface}</p>
      <p id="pad-name">{@pad || "none"}</p>
      <p id="mount-count">{@mounts}</p>

      <.link
        id="open-east-pad"
        patch={~p"/features/07-liveview-navigation/10-narsarsuaq-parent-patch/pads/east"}
      >
        East pad
      </.link>
      <.link
        id="back-to-board"
        patch={~p"/features/07-liveview-navigation/10-narsarsuaq-parent-patch"}
      >
        Back to board
      </.link>
    </Layouts.catalog>
    """
  end
end
