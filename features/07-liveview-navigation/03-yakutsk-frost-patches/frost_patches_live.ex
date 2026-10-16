# LiveView navigation · 03 · Yakutsk frost patches
#
# Teaches:
# - <.link patch={~p}> is the HEEx live_patch
# - The process stays; handle_params/3 reads the frost stand

defmodule PhoenixMultivitaminWeb.YakutskFrostPatchesLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Yakutsk frost patches")
     |> assign(:clerk, "Sardaana")
     |> assign(:craft, "Sukhoi Superjet 100")
     |> assign(:mounts, 1)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    stand = Map.get(params, "stand", "north")
    {:noreply, assign(socket, :stand, stand)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView navigation · 03 · Yakutsk frost patches
      </p>

      <h1>Yakutsk frost patches</h1>
      <p class="lede">
        Clerk {@clerk} patches the {@craft} between frost stands with a <code>patch</code>
        link. The process stays.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="stand-name">{@stand}</p>
      <p id="mount-count">{@mounts}</p>

      <.link
        id="patch-south"
        patch={~p"/features/07-liveview-navigation/03-yakutsk-frost-patches?#{[stand: "south"]}"}
      >
        South stand
      </.link>
    </Layouts.catalog>
    """
  end
end
