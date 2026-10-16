# Streams · 05 · Nadi stream container
#
# Teaches:
# - phx-update="stream" on the container

defmodule PhoenixMultivitaminWeb.NadiStreamContainerLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Nadi stream container")
     |> assign(:clerk, "Litia")
     |> assign(:craft, "Boeing 737-800")
     |> stream(:slots, [%{id: "nadi-west", label: "Nadi west"}])}
  end

  @impl true
  def handle_event("add_momi", _params, socket) do
    {:noreply, stream_insert(socket, :slots, %{id: "momi", label: "Momi"})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 05 · Nadi stream container
      </p>

      <h1>Nadi stream container</h1>
      <p class="lede">
        Clerk {@clerk} streams {@craft} slots at Nadi. The parent owns
        phx-update="stream".
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="add-momi" type="button" phx-click="add_momi">Add Momi</button>

      <div id="slots" phx-update="stream">
        <p :for={{id, slot} <- @streams.slots} id={id}>{slot.label}</p>
      </div>
    </Layouts.catalog>
    """
  end
end
