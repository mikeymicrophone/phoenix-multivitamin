# LiveComponents · 06 · Murmansk batch rack
#
# Teaches:
# - update_many/1 for a batch of components

defmodule PhoenixMultivitaminWeb.MurmanskBatchRackLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.MurmanskBatchCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Murmansk batch rack")
     |> assign(:clerk, "Lyudmila")
     |> assign(:craft, "Tupolev Tu-154")
     |> assign(:pads, ["kola", "teriberka", "lovozero"])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 06 · Murmansk batch rack
      </p>

      <h1>Murmansk batch rack</h1>
      <p class="lede">
        Clerk {@clerk} loads three {@craft} QNH cells in one update_many/1.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.live_component :for={pad <- @pads} module={MurmanskBatchCell} id={pad} />
    </Layouts.catalog>
    """
  end
end
