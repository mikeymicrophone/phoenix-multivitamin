# Streams · 12 · Funafuti once stream
#
# Teaches:
# - Don't consume the stream twice in one render

defmodule PhoenixMultivitaminWeb.FunafutiOnceStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    hops = [%{id: "nanumea", name: "Nanumea"}]

    {:ok,
     socket
     |> assign(:page_title, "Funafuti once stream")
     |> assign(:clerk, "Talia")
     |> assign(:craft, "DHC-2 Beaver")
     |> assign(:hop_count, length(hops))
     |> stream(:hops, hops)}
  end

  @impl true
  def handle_event("add_nukufetau", _params, socket) do
    {:noreply,
     socket
     |> assign(:hop_count, socket.assigns.hop_count + 1)
     |> stream_insert(:hops, %{id: "nukufetau", name: "Nukufetau"})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 12 · Funafuti once stream
      </p>

      <h1>Funafuti once stream</h1>
      <p class="lede">
        Clerk {@clerk} lists {@craft} hops at Funafuti once. The count is an
        assign, not a second walk of the stream.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="hop-count">{@hop_count}</p>

      <button id="add-nukufetau" type="button" phx-click="add_nukufetau">
        Add Nukufetau
      </button>

      <div id="hops" phx-update="stream">
        <p :for={{id, hop} <- @streams.hops} id={id}>{hop.name}</p>
      </div>
    </Layouts.catalog>
    """
  end
end
