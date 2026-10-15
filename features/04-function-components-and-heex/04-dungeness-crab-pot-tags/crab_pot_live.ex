# Function components and HEEx · 04 · Dungeness crab pot tags
#
# Teaches:
# - :for, :if, and :key on HTML tags
# - :let receiving a value from render_slot/2
# - :if on a function component omits the whole tag

defmodule PhoenixMultivitaminWeb.DungenessCrabPotTagsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Dungeness crab pot tags")
     |> assign(:grounds, "Dungeness Bay")
     |> assign(:skipper, "Harlan")
     |> assign(:show_soaking?, true)
     |> assign(:pots, [
       %{id: "pot-12", buoy: "red-over-white", soak_nights: 2, legal?: true, crabs: 6},
       %{id: "pot-19", buoy: "chartreuse", soak_nights: 1, legal?: false, crabs: 2},
       %{id: "pot-27", buoy: "orange-over-black", soak_nights: 3, legal?: true, crabs: 9}
     ])}
  end

  @impl true
  def handle_event("hide_soaking", _params, socket) do
    {:noreply, assign(socket, :show_soaking?, false)}
  end

  def handle_event("show_soaking", _params, socket) do
    {:noreply, assign(socket, :show_soaking?, true)}
  end

  def handle_event("pull_pot_19", _params, socket) do
    pots = Enum.reject(socket.assigns.pots, &(&1.id == "pot-19"))
    {:noreply, assign(socket, :pots, pots)}
  end

  slot :inner_block, required: true
  attr :pot, :map, required: true
  attr :id, :string, required: true

  def pot_tag(assigns) do
    ~H"""
    <article id={@id} class="scenario">
      <h2>Pot {String.replace(@pot.id, "pot-", "")}</h2>
      <p>Buoy {@pot.buoy}</p>
      <p id={"#{@id}-body"}>{render_slot(@inner_block, @pot)}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 04 · Dungeness crab pot tags
      </p>

      <h1>Dungeness crab pot tags</h1>
      <p class="lede">
        {@skipper} works {@grounds} from the troller <em>Ceto</em>. Tags loop
        with <code>:for</code>
        and <code>:key</code>. Soaking pots hide with <code>:if</code>. Each tag yields the pot map to <code>:let</code>.
      </p>

      <div class="watch-actions">
        <button id="hide-soaking" type="button" phx-click="hide_soaking">Hide soaking pots</button>
        <button id="show-soaking" type="button" phx-click="show_soaking">Show soaking pots</button>
        <button id="pull-pot-19" type="button" phx-click="pull_pot_19">Pull pot 19</button>
      </div>

      <div id="pot-string">
        <.pot_tag
          :let={tagged}
          :for={pot <- @pots}
          :if={@show_soaking? or pot.legal?}
          :key={pot.id}
          id={pot.id}
          pot={pot}
        >
          <span data-crabs={tagged.crabs}>{tagged.crabs} keepers</span>
          <span :if={tagged.legal?} data-status="legal">legal soak, {tagged.soak_nights} nights</span>
          <span :if={not tagged.legal?} data-status="short">short soak, leave it</span>
        </.pot_tag>
      </div>
    </Layouts.catalog>
    """
  end
end
