# Function components and HEEx · 04 · Tekapo glider tags
#
# Teaches:
# - :for, :if, and :key on HTML tags
# - :let receiving a value from render_slot/2
# - :if on a function component omits the whole tag

defmodule PhoenixMultivitaminWeb.TekapoGliderTagsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Tekapo glider tags")
     |> assign(:field, "Lake Tekapo")
     |> assign(:tow_pilot, "Miriama")
     |> assign(:show_holding?, true)
     |> assign(:gliders, [
       %{id: "glider-12", tape: "red-over-white", line_nights: 2, released?: true, hours: 6},
       %{id: "glider-19", tape: "chartreuse", line_nights: 1, released?: false, hours: 2},
       %{id: "glider-27", tape: "orange-over-black", line_nights: 3, released?: true, hours: 9}
     ])}
  end

  @impl true
  def handle_event("hide_holding", _params, socket) do
    {:noreply, assign(socket, :show_holding?, false)}
  end

  def handle_event("show_holding", _params, socket) do
    {:noreply, assign(socket, :show_holding?, true)}
  end

  def handle_event("pull_glider_19", _params, socket) do
    gliders = Enum.reject(socket.assigns.gliders, &(&1.id == "glider-19"))
    {:noreply, assign(socket, :gliders, gliders)}
  end

  slot :inner_block, required: true
  attr :glider, :map, required: true
  attr :id, :string, required: true

  def glider_tag(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>Glider {String.replace(@glider.id, "glider-", "")}</h2>
      <p>Tape {@glider.tape}</p>
      <p id={"#{@id}-body"}>{render_slot(@inner_block, @glider)}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 04 · Tekapo glider tags
      </p>

      <h1>Tekapo glider tags</h1>
      <p class="lede">
        {@tow_pilot} tows ASK-21s at {@field}. Tags loop
        with <code>:for</code>
        and <code>:key</code>. Holding gliders hide with <code>:if</code>. Each tag yields the glider map to <code>:let</code>.
      </p>

      <div class="watch-actions">
        <button id="hide-holding" type="button" phx-click="hide_holding">Hide holding gliders</button>
        <button id="show-holding" type="button" phx-click="show_holding">Show holding gliders</button>
        <button id="pull-glider-19" type="button" phx-click="pull_glider_19">Pull glider 19</button>
      </div>

      <div id="glider-line">
        <.glider_tag
          :let={tagged}
          :for={glider <- @gliders}
          :if={@show_holding? or glider.released?}
          :key={glider.id}
          id={glider.id}
          glider={glider}
        >
          <span data-hours={tagged.hours}>{tagged.hours} hours</span>
          <span :if={tagged.released?} data-status="released">released, {tagged.line_nights} nights</span>
          <span :if={not tagged.released?} data-status="short">short wait, leave it</span>
        </.glider_tag>
      </div>
    </Layouts.catalog>
    """
  end
end
