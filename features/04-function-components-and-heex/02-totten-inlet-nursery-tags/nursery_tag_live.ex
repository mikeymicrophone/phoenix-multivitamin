# Function components and HEEx · 02 · Totten Inlet nursery tags
#
# Teaches:
# - inner_block versus named slots
# - Slot attrs declared inside slot/3
# - Multiple named slot entries of the same name
# - :if on a named slot omits that entry from the list

defmodule PhoenixMultivitaminWeb.TottenInletNurseryTagsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Totten Inlet nursery tags")
     |> assign(:farm, "Taylor Shellfish · Totten Inlet")
     |> assign(:husbandry, "Nara")
     |> assign(:show_grading?, true)
     |> assign(:extra_mesh?, false)}
  end

  @impl true
  def handle_event("hide_grading", _params, socket) do
    {:noreply, assign(socket, :show_grading?, false)}
  end

  def handle_event("show_grading", _params, socket) do
    {:noreply, assign(socket, :show_grading?, true)}
  end

  def handle_event("add_three_mill_mesh", _params, socket) do
    {:noreply, assign(socket, :extra_mesh?, true)}
  end

  slot :inner_block, required: true

  slot :mesh, required: true do
    attr :size, :string, required: true
    attr :week, :integer, required: true
  end

  slot :grade do
    attr :count_per_shell, :integer, required: true
  end

  slot :footer

  attr :species, :string, required: true
  attr :bag, :string, required: true
  attr :id, :string, required: true

  def nursery_tag(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>{@species}</h2>
      <p>Bag {@bag}</p>
      <p id={"#{@id}-note"}>{render_slot(@inner_block)}</p>
      <ul id={"#{@id}-meshes"}>
        <li :for={mesh <- @mesh} data-mesh={mesh.size}>
          {mesh.size} mesh at week {mesh.week}
        </li>
      </ul>
      <p :if={@grade != []} id={"#{@id}-grade"}>
        <span :for={grade <- @grade}>
          Grade {grade.count_per_shell} seed per shell. {render_slot(grade)}
        </span>
      </p>
      <p :if={@grade == []} id={"#{@id}-ungraded"}>Not graded this pull.</p>
      <footer id={"#{@id}-footer"}>{render_slot(@footer) || "No hauler noted."}</footer>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 02 · Totten Inlet nursery tags
      </p>

      <h1>Totten Inlet nursery tags</h1>
      <p class="lede">
        {@husbandry} hangs seed bags at {@farm}. The husbandry note is the
        default slot. Mesh sizes are a named slot with attrs. Grading is an
        optional named slot that can be withheld with <code>:if</code>.
      </p>

      <div class="watch-actions">
        <button id="hide-grading" type="button" phx-click="hide_grading">Skip grading</button>
        <button id="show-grading" type="button" phx-click="show_grading">Post grading</button>
        <button id="add-three-mill-mesh" type="button" phx-click="add_three_mill_mesh">
          Add 3 mm mesh
        </button>
      </div>

      <.nursery_tag id="pacific-bag" species="Pacific oyster" bag="TI-P-441">
        Flip the bag at slack water, south pontoon.
        <:mesh size="6 mm" week={4}>First shake.</:mesh>
        <:mesh size="4 mm" week={7}>Second shake.</:mesh>
        <:mesh :if={@extra_mesh?} size="3 mm" week={9}>Hardening mesh.</:mesh>
        <:grade :if={@show_grading?} count_per_shell={18}>
          Cull the boxy shells.
        </:grade>
        <:footer>
          Hauler Skookum coming on the evening tide.
        </:footer>
      </.nursery_tag>

      <.nursery_tag id="olympia-bag" species="Olympia oyster" bag="TI-O-12">
        Keep the Olympias in the shade of the north rack.
        <:mesh size="2 mm" week={11}></:mesh>
      </.nursery_tag>
    </Layouts.catalog>
    """
  end
end
