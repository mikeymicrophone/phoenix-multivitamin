# LiveView navigation · 09 · Gelephu QNH query
#
# Teaches:
# - Query params survive a patch that only changes another key
# - handle_params/3 still sees the kept QNH

defmodule PhoenixMultivitaminWeb.GelephuQnhQueryLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Gelephu QNH query")
     |> assign(:clerk, "Pema")
     |> assign(:craft, "Dornier 228")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    qnh = Map.get(params, "qnh", "1013")
    watch = Map.get(params, "watch", "morning")

    {:noreply,
     socket
     |> assign(:qnh, qnh)
     |> assign(:watch, watch)}
  end

  @impl true
  def handle_event("patch_evening", _params, socket) do
    {:noreply,
     push_patch(socket,
       to:
         ~p"/features/07-liveview-navigation/09-gelephu-qnh-query?#{[qnh: socket.assigns.qnh, watch: "evening"]}"
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 09 · Gelephu QNH query
      </p>

      <h1>Gelephu QNH query</h1>
      <p class="lede">
        Clerk {@clerk} keeps QNH on the {@craft} while patching the watch.
        The query string still carries the pressure.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="qnh-value">{@qnh}</p>
      <p id="watch-name">{@watch}</p>

      <button id="patch-evening" type="button" phx-click="patch_evening">Patch evening</button>
    </Layouts.catalog>
    """
  end
end
