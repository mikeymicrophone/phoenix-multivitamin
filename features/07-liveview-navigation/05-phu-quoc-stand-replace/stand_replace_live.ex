# LiveView navigation · 05 · Phu Quoc stand replace
#
# Teaches:
# - push_patch(..., replace: true) does not stack history
# - The stand still swaps through handle_params/3

defmodule PhoenixMultivitaminWeb.PhuQuocStandReplaceLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Phu Quoc stand replace")
     |> assign(:clerk, "Linh")
     |> assign(:craft, "ATR 42")
     |> assign(:replacements, 0)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    stand = Map.get(params, "stand", "a3")
    {:noreply, assign(socket, :stand, stand)}
  end

  @impl true
  def handle_event("replace_b7", _params, socket) do
    {:noreply,
     socket
     |> assign(:replacements, socket.assigns.replacements + 1)
     |> push_patch(
       to: ~p"/features/07-liveview-navigation/05-phu-quoc-stand-replace?#{[stand: "b7"]}",
       replace: true
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 05 · Phu Quoc stand replace
      </p>

      <h1>Phu Quoc stand replace</h1>
      <p class="lede">
        Clerk {@clerk} slides the {@craft} onto B7 with <code>replace: true</code>.
        The watch does not stack a second history entry.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="stand-name">{@stand}</p>
      <p id="replace-count">{@replacements}</p>
      <p id="replace-flag">replace</p>

      <button id="replace-b7" type="button" phx-click="replace_b7">Replace onto B7</button>
    </Layouts.catalog>
    """
  end
end
