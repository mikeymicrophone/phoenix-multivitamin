# Streams · 04 · Jomsom delete stream
#
# Teaches:
# - stream_delete/3 removing a finished row

defmodule PhoenixMultivitaminWeb.JomsomDeleteStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Jomsom delete stream")
     |> assign(:clerk, "Dorje")
     |> assign(:craft, "Cessna 206 Stationair")
     |> stream(:legs, [
       %{id: "mustang", name: "Mustang"},
       %{id: "kali", name: "Kali Gandaki"}
     ])}
  end

  @impl true
  def handle_event("finish_mustang", _params, socket) do
    {:noreply, stream_delete(socket, :legs, %{id: "mustang", name: "Mustang"})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 04 · Jomsom delete stream
      </p>

      <h1>Jomsom delete stream</h1>
      <p class="lede">
        Clerk {@clerk} pulls a finished {@craft} Mustang leg off the Jomsom board.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="finish-mustang" type="button" phx-click="finish_mustang">
        Finish Mustang
      </button>

      <div id="legs" phx-update="stream">
        <div :for={{id, leg} <- @streams.legs} id={id}>
          <span id={"leg-" <> leg.id}>{leg.name}</span>
        </div>
      </div>
    </Layouts.catalog>
    """
  end
end
