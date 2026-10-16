# Streams · 02 · Lüderitz stand stream
#
# Teaches:
# - stream_insert/4 appending a row

defmodule PhoenixMultivitaminWeb.LuderitzStandStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Lüderitz stand stream", "Immanuel", "Swearingen Metro III")
     |> stream(:stands, [%{id: "diamond", name: "Diamond"}])}
  end

  @impl true
  def handle_event("append_kolmanskop", _params, socket) do
    {:noreply, stream_insert(socket, :stands, %{id: "kolmanskop", name: "Kolmanskop"})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 02 · Lüderitz stand stream
      </p>

      <h1>Lüderitz stand stream</h1>
      <p class="lede">
        Clerk {@clerk} appends a {@craft} stand at Lüderitz.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button id="append-kolmanskop" type="button" phx-click="append_kolmanskop">
        Append Kolmanskop
      </button>

      <div id="stands" phx-update="stream">
        <div :for={{id, stand} <- @streams.stands} id={id}>
          <span id={"stand-" <> stand.id}>{stand.name}</span>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
