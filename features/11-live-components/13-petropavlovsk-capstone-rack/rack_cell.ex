# LiveComponents · 13 · Petropavlovsk rack cell
#
# Teaches:
# - update_many/1 plus a parent that coordinates a ping

defmodule PhoenixMultivitaminWeb.PetropavlovskRackCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @sites %{"avacha" => "Avacha", "bezymianny" => "Bezymianny"}

  @impl true
  def update_many(assigns_sockets) do
    batch_size = length(assigns_sockets)

    Enum.map(assigns_sockets, fn {assigns, socket} ->
      socket
      |> assign(assigns)
      |> assign(:site, Map.fetch!(@sites, assigns.id))
      |> assign(:batch_size, batch_size)
    end)
  end

  @impl true
  def handle_event("hail_parent", %{"site" => site}, socket) do
    send(self(), {:hail, site})
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id={"site-" <> @id}>{@site}</p>
      <p id={"batch-" <> @id}>{@batch_size}</p>
      <button
        id={"hail-" <> @id}
        type="button"
        phx-click="hail_parent"
        phx-value-site={@site}
        phx-target={@myself}
      >
        Hail {@site}
      </button>
    </div>
    """
  end
end
