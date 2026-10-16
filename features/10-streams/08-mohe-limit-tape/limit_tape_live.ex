# Streams · 08 · Mohe limit tape
#
# Teaches:
# - Limit and the row that falls off the end

defmodule PhoenixMultivitaminWeb.MoheLimitTapeLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    tapes = [
      %{id: "one", body: "Ice fog"},
      %{id: "two", body: "Rime on the vane"},
      %{id: "three", body: "QNH 1011"}
    ]

    {:ok,
     socket
     |> assign(:page_title, "Mohe limit tape")
     |> assign(:clerk, "Bai")
     |> assign(:craft, "Comac ARJ21")
     |> stream(:tapes, tapes, limit: 3)}
  end

  @impl true
  def handle_event("prepend_aurora", _params, socket) do
    {:noreply,
     stream_insert(socket, :tapes, %{id: "aurora", body: "Aurora over the Amur"},
       at: 0,
       limit: 3
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 08 · Mohe limit tape
      </p>

      <h1>Mohe limit tape</h1>
      <p class="lede">
        Clerk {@clerk} keeps three {@craft} tape lines at Mohe. A new aurora
        line pushes QNH off the end.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="prepend-aurora" type="button" phx-click="prepend_aurora">
        Prepend aurora
      </button>

      <div id="tapes" phx-update="stream">
        <p :for={{id, tape} <- @streams.tapes} id={id}>{tape.body}</p>
      </div>
    </Layouts.catalog>
    """
  end
end
