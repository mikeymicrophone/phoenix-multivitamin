# LiveView navigation · 07 · Comodoro Saab patch
#
# Teaches:
# - push_patch from an event, not a link
# - The event can also bump an assign before the patch

defmodule PhoenixMultivitaminWeb.ComodoroSaabPatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Comodoro Saab patch")
     |> assign(:clerk, "Facundo")
     |> assign(:craft, "Saab 340")
     |> assign(:gusts, 0)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    pad = Map.get(params, "pad", "north")
    {:noreply, assign(socket, :pad, pad)}
  end

  @impl true
  def handle_event("gust_south", _params, socket) do
    {:noreply,
     socket
     |> assign(:gusts, socket.assigns.gusts + 1)
     |> push_patch(
       to: ~p"/features/07-liveview-navigation/07-comodoro-saab-patch?#{[pad: "south"]}"
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 07 · Comodoro Saab patch
      </p>

      <h1>Comodoro Saab patch</h1>
      <p class="lede">
        Clerk {@clerk} gusts the {@craft} south from a button, not a link.
        The event bumps the gust count, then patches.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="pad-name">{@pad}</p>
      <p id="gust-count">{@gusts}</p>

      <button id="gust-south" type="button" phx-click="gust_south">Gust south</button>
    </Layouts.catalog>
    """
  end
end
