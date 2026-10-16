# Streams · 04 · Jomsom delete stream
#
# Teaches:
# - stream_delete_by_dom_id/3 removes a row without fetching its record
# - Binary pattern matching checks the stream's DOM ID prefix

defmodule PhoenixMultivitaminWeb.JomsomDeleteStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Jomsom delete stream", "Dorje", "Cessna 206 Stationair")
     |> stream(:legs, [
       %{id: "mustang", name: "Mustang"},
       %{id: "kali", name: "Kali Gandaki"}
     ])}
  end

  @impl true
  def handle_event("finish_mustang", %{"dom_id" => "legs-" <> leg_id = dom_id}, socket)
      when leg_id in ["mustang", "kali"] do
    {:noreply, stream_delete_by_dom_id(socket, :legs, dom_id)}
  end

  def handle_event("finish_mustang", _params, socket) do
    {:noreply, put_flash(socket, :error, "Choose a posted Jomsom leg.")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 04 · Jomsom delete stream
      </p>

      <h1>Jomsom delete stream</h1>
      <p class="lede">
        Clerk {@clerk} pulls a finished {@craft} Mustang leg off the Jomsom board.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button
        id="finish-mustang"
        type="button"
        phx-click="finish_mustang"
        phx-value-dom_id="legs-mustang"
      >
        Finish Mustang
      </button>

      <div id="legs" phx-update="stream">
        <div :for={{id, leg} <- @streams.legs} id={id}>
          <span id={"leg-" <> leg.id}>{leg.name}</span>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
