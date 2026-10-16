# Streams · 11 · Calama insert after
#
# Teaches:
# - Insert after a given id

defmodule PhoenixMultivitaminWeb.CalamaInsertAfterLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Calama insert after", "Rocío", "Boeing 787-8")
     |> stream(:sectors, [
       %{id: "north", name: "Chuquicamata north"},
       %{id: "south", name: "Loa south"}
     ])}
  end

  @impl true
  def handle_event("insert_mid", _params, socket) do
    {:noreply, stream_insert(socket, :sectors, %{id: "mid", name: "Calama mid"}, at: 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 11 · Calama insert after
      </p>

      <h1>Calama insert after</h1>
      <p class="lede">
        Clerk {@clerk} slides a mid sector for the {@craft} after Chuquicamata north.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button id="insert-mid" type="button" phx-click="insert_mid">
        Insert Calama mid
      </button>

      <div id="sectors" phx-update="stream">
        <p :for={{id, sector} <- @streams.sectors} id={id}>{sector.name}</p>
      </div>
    </Layouts.app>
    """
  end
end
