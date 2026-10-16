# LiveView navigation · 11 · Labuan Bajo Komodo cell
#
# Teaches:
# - A LiveComponent sends the stand to the parent
# - The parent push_patches

defmodule PhoenixMultivitaminWeb.LabuanBajoKomodoCellLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Labuan Bajo Komodo cell")
     |> assign(:clerk, "Wayan")
     |> assign(:craft, "Cessna 208")
     |> assign(:mounts, 1)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    stand = Map.get(params, "stand", "komodo")
    {:noreply, assign(socket, :stand, stand)}
  end

  @impl true
  def handle_info({:open_stand, stand}, socket) do
    {:noreply,
     push_patch(socket,
       to: ~p"/features/07-liveview-navigation/11-labuan-bajo-komodo-cell?#{[stand: stand]}"
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 11 · Labuan Bajo Komodo cell
      </p>

      <h1>Labuan Bajo Komodo cell</h1>
      <p class="lede">
        Clerk {@clerk} parks the {@craft} from a LiveComponent. The cell
        sends the stand. This parent patches.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="stand-name">{@stand}</p>
      <p id="mount-count">{@mounts}</p>

      <.live_component
        module={PhoenixMultivitaminWeb.LabuanBajoKomodoCell}
        id="komodo-cell"
        clerk={@clerk}
        craft={@craft}
      />
    </Layouts.catalog>
    """
  end
end
