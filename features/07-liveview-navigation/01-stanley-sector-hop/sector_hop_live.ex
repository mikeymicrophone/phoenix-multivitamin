# LiveView navigation · 01 · Stanley sector hop
#
# Teaches:
# - push_patch/2 reuses the LiveView process
# - handle_params/3 runs again after the patch

defmodule PhoenixMultivitaminWeb.StanleySectorHopLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @sectors %{
    "east" => %{name: "East sector", clerk: "Kezia", wind: "28018KT"},
    "west" => %{name: "West sector", clerk: "Kezia", wind: "25022KT"}
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Stanley sector hop")
     |> assign(:craft, "DHC-6 Twin Otter")
     |> assign(:mounts, 1)
     |> assign(:hops, 0)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    key = Map.get(params, "sector", "east")
    sector = Map.get(@sectors, key, @sectors["east"])

    {:noreply,
     socket
     |> assign(:sector_key, key)
     |> assign(:sector, sector)}
  end

  @impl true
  def handle_event("hop_west", _params, socket) do
    {:noreply,
     socket
     |> assign(:hops, socket.assigns.hops + 1)
     |> push_patch(
       to: ~p"/features/07-liveview-navigation/01-stanley-sector-hop?#{[sector: "west"]}"
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 01 · Stanley sector hop
      </p>

      <h1>Stanley sector hop</h1>
      <p class="lede">
        Clerk {@sector.clerk} hops the {@craft} between Stanley sectors. A patch
        reuses this process and runs handle_params/3 again.
      </p>

      <dl class="station-meta">
        <dt>Clerk</dt>
        <dd id="clerk-name">{@sector.clerk}</dd>
        <dt>Craft</dt>
        <dd id="craft-name">{@craft}</dd>
        <dt>Sector</dt>
        <dd id="sector-name">{@sector.name}</dd>
        <dt>Wind</dt>
        <dd id="sector-wind">{@sector.wind}</dd>
        <dt>Mounts</dt>
        <dd id="mount-count">{@mounts}</dd>
        <dt>Hops</dt>
        <dd id="hop-count">{@hops}</dd>
      </dl>

      <button id="hop-west" type="button" phx-click="hop_west">Hop west</button>
    </Layouts.catalog>
    """
  end
end
