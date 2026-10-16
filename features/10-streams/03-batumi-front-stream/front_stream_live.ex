# Streams · 03 · Batumi front stream
#
# Teaches:
# - stream_insert/4 at the front of the board

defmodule PhoenixMultivitaminWeb.BatumiFrontStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Batumi front stream")
     |> assign(:clerk, "Nino")
     |> assign(:craft, "Yakovlev Yak-40")
     |> stream(:notams, [%{id: "sea", body: "Black Sea swell"}])}
  end

  @impl true
  def handle_event("prepend_caucasus", _params, socket) do
    {:noreply, stream_insert(socket, :notams, %{id: "caucasus", body: "Caucasus wave"}, at: 0)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 03 · Batumi front stream
      </p>

      <h1>Batumi front stream</h1>
      <p class="lede">
        Clerk {@clerk} prepends a Caucasus wave ahead of the {@craft} sea swell.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="prepend-caucasus" type="button" phx-click="prepend_caucasus">
        Prepend Caucasus
      </button>

      <div id="notams" phx-update="stream">
        <p :for={{id, notam} <- @streams.notams} id={id}>{notam.body}</p>
      </div>
    </Layouts.catalog>
    """
  end
end
