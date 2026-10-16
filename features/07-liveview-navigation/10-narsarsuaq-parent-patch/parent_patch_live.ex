# LiveView navigation · 10 · Narsarsuaq parent patch
#
# Teaches:
# - A child pad path patches back to the parent board
# - The same LiveView handles both live_actions
# - Socket patterns distinguish actions; a guard validates the child pad

defmodule PhoenixMultivitaminWeb.NarsarsuaqParentPatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Narsarsuaq parent patch", "Naja", "Dash 7")
     |> assign(:mounts, 1)}
  end

  @impl true
  def handle_params(%{"pad" => pad}, _uri, %{assigns: %{live_action: :pad}} = socket)
      when pad in ~w(east) do
    {:noreply, assign(socket, pad: pad, surface: :pad)}
  end

  def handle_params(_params, _uri, %{assigns: %{live_action: :board}} = socket) do
    {:noreply, assign(socket, pad: nil, surface: :board)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply,
     socket
     |> assign(pad: nil, surface: :board)
     |> push_patch(to: ~p"/features/07-liveview-navigation/10-narsarsuaq-parent-patch")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 10 · Narsarsuaq parent patch
      </p>

      <h1>Narsarsuaq parent patch</h1>
      <p class="lede">
        Clerk {@clerk} walks the {@craft} onto the east pad, then patches back
        to the parent board.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
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
    </Layouts.app>
    """
  end
end
