# Streams · 03 · Batumi front stream
#
# Teaches:
# - stream_insert/4 at the front of the board
# - Enforced struct fields, a String.Chars implementation, and with lookup

defmodule PhoenixMultivitaminWeb.BatumiFrontStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.BatumiNotam

  @notams %{
    "sea" => %BatumiNotam{id: "sea", body: "Black Sea swell"},
    "caucasus" => %BatumiNotam{id: "caucasus", body: "Caucasus wave"}
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Batumi front stream", "Nino", "Yakovlev Yak-40")
     |> stream(:notams, [Map.fetch!(@notams, "sea")])}
  end

  @impl true
  def handle_event("prepend_caucasus", %{"id" => id}, socket) do
    with {:ok, %BatumiNotam{} = notam} <- Map.fetch(@notams, id) do
      {:noreply, stream_insert(socket, :notams, notam, at: 0)}
    else
      :error -> {:noreply, put_flash(socket, :error, "No Batumi NOTAM for that identifier.")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 03 · Batumi front stream
      </p>

      <h1>Batumi front stream</h1>
      <p class="lede">
        Clerk {@clerk} prepends a Caucasus wave ahead of the {@craft} sea swell.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button id="prepend-caucasus" type="button" phx-click="prepend_caucasus" phx-value-id="caucasus">
        Prepend Caucasus
      </button>

      <div id="notams" phx-update="stream">
        <p :for={{id, notam} <- @streams.notams} id={id}>{to_string(notam)}</p>
      </div>
    </Layouts.app>
    """
  end
end
