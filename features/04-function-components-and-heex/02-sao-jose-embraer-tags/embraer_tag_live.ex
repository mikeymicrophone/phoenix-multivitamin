# Function components and HEEx · 02 · São José Embraer tags
#
# Teaches:
# - inner_block versus named slots
# - Slot attrs declared inside slot/3
# - Multiple named slot entries of the same name
# - :if on a named slot omits that entry from the list

defmodule PhoenixMultivitaminWeb.SaoJoseEmbraerTagsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "São José Embraer tags")
     |> assign(:plant, "Embraer · São José dos Campos")
     |> assign(:inspector, "Caio")
     |> assign(:show_grading?, true)
     |> assign(:extra_ply?, false)}
  end

  @impl true
  def handle_event("hide_grading", _params, socket) do
    {:noreply, assign(socket, :show_grading?, false)}
  end

  def handle_event("show_grading", _params, socket) do
    {:noreply, assign(socket, :show_grading?, true)}
  end

  def handle_event("add_three_mill_ply", _params, socket) do
    {:noreply, assign(socket, :extra_ply?, true)}
  end

  slot :inner_block, required: true

  slot :ply, required: true do
    attr :size, :string, required: true
    attr :week, :integer, required: true
  end

  slot :grade do
    attr :count_per_frame, :integer, required: true
  end

  slot :footer

  attr :variant, :string, required: true
  attr :jig, :string, required: true
  attr :id, :string, required: true

  def embraer_tag(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>{@variant}</h2>
      <p>Jig {@jig}</p>
      <p id={"#{@id}-note"}>{render_slot(@inner_block)}</p>
      <ul id={"#{@id}-plies"}>
        <li :for={ply <- @ply} data-ply={ply.size}>
          {ply.size} ply at week {ply.week}
        </li>
      </ul>
      <p :if={@grade != []} id={"#{@id}-grade"}>
        <span :for={grade <- @grade}>
          Grade {grade.count_per_frame} fasteners per frame. {render_slot(grade)}
        </span>
      </p>
      <p :if={@grade == []} id={"#{@id}-ungraded"}>Not graded this bay.</p>
      <footer id={"#{@id}-footer"}>{render_slot(@footer) || "No inspector noted."}</footer>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 02 · São José Embraer tags
      </p>

      <h1>São José Embraer tags</h1>
      <p class="lede">
        {@inspector} inspects E175 skins at {@plant}. The inspector note is the
        default slot. Ply sizes are a named slot with attrs. Grading is an
        optional named slot that can be withheld with <code>:if</code>.
      </p>

      <div class="watch-actions">
        <button id="hide-grading" type="button" phx-click="hide_grading">Skip grading</button>
        <button id="show-grading" type="button" phx-click="show_grading">Post grading</button>
        <button id="add-three-mill-ply" type="button" phx-click="add_three_mill_ply">
          Add 3 mm ply
        </button>
      </div>

      <.embraer_tag id="e175-wing" variant="E175 wing" jig="SJC-W-441">
        Walk the wing at first light, south jig.
        <:ply size="6 mm" week={4}>First layup.</:ply>
        <:ply size="4 mm" week={7}>Second layup.</:ply>
        <:ply :if={@extra_ply?} size="3 mm" week={9}>Close-out ply.</:ply>
        <:grade :if={@show_grading?} count_per_frame={18}>
          Cull the proud rivets.
        </:grade>
        <:footer>
          Inspector desk closing after the night shift.
        </:footer>
      </.embraer_tag>

      <.embraer_tag id="e175-nose" variant="E175 nose" jig="SJC-N-12">
        Keep the nose skins in the shade of the north rack.
        <:ply size="2 mm" week={11}></:ply>
      </.embraer_tag>
    </Layouts.catalog>
    """
  end
end
