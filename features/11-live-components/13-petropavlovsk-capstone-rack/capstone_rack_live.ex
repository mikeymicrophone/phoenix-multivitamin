# LiveComponents · 13 · Petropavlovsk capstone rack
#
# Teaches:
# - Several components, update_many, and a parent that coordinates

defmodule PhoenixMultivitaminWeb.PetropavlovskCapstoneRackLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.PetropavlovskRackCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Petropavlovsk capstone rack")
     |> assign(:clerk, "Yegor")
     |> assign(:craft, "Kamov Ka-27")
     |> assign(:last_hail, "quiet")
     |> assign(:pads, ["avacha", "bezymianny"])}
  end

  @impl true
  def handle_info({:hail, site}, socket) do
    {:noreply, assign(socket, :last_hail, site)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 13 · Petropavlovsk capstone rack
      </p>

      <h1>Petropavlovsk capstone rack</h1>
      <p class="lede">
        Clerk {@clerk} coordinates two {@craft} hoist cells. One batch fills
        the sites. A hail lands on the parent.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="last-hail">{@last_hail}</p>

      <.live_component :for={pad <- @pads} module={PetropavlovskRackCell} id={pad} />
    </Layouts.catalog>
    """
  end
end
