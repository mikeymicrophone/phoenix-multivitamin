# LiveView navigation · 06 · Timbuktu dust params
#
# Teaches:
# - The first handle_params/3 runs after mount
# - A later patch runs handle_params/3 again with a different via

defmodule PhoenixMultivitaminWeb.TimbuktuDustParamsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Timbuktu dust params")
     |> assign(:clerk, "Aissata")
     |> assign(:craft, "CASA C-212")
     |> assign(:params_runs, 0)
     |> assign(:params_via, :mount)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    via = if socket.assigns.params_runs == 0, do: :mount, else: :patch
    lane = Map.get(params, "lane", "harmattan")

    {:noreply,
     socket
     |> assign(:params_via, via)
     |> assign(:params_runs, socket.assigns.params_runs + 1)
     |> assign(:lane, lane)}
  end

  @impl true
  def handle_event("patch_sahel", _params, socket) do
    {:noreply,
     push_patch(socket,
       to: ~p"/features/07-liveview-navigation/06-timbuktu-dust-params?#{[lane: "sahel"]}"
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 06 · Timbuktu dust params
      </p>

      <h1>Timbuktu dust params</h1>
      <p class="lede">
        Clerk {@clerk} posts the {@craft} dust lane. The first params run is
        after mount. A later patch is a second run.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="lane-name">{@lane}</p>
      <p id="params-via">{@params_via}</p>
      <p id="params-runs">{@params_runs}</p>

      <button id="patch-sahel" type="button" phx-click="patch_sahel">Patch sahel</button>
    </Layouts.catalog>
    """
  end
end
