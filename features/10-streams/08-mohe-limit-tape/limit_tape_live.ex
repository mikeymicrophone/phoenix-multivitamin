# Streams · 08 · Mohe limit tape
#
# Teaches:
# - Positive and negative limits trim opposite ends of a stream
# - A zipped comprehension builds the tape rows

defmodule PhoenixMultivitaminWeb.MoheLimitTapeLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    tapes =
      for {id, body} <- Enum.zip(~w(one two three), ["Ice fog", "Rime on the vane", "QNH 1011"]) do
        %{id: id, body: body}
      end

    {:ok,
     socket
     |> assign_scenario("Mohe limit tape", "Bai", "Comac ARJ21")
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

  def handle_event("append_aurora", _params, socket) do
    {:noreply,
     stream_insert(socket, :tapes, %{id: "aurora", body: "Aurora over the Amur"},
       at: -1,
       limit: -3
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 08 · Mohe limit tape
      </p>

      <h1>Mohe limit tape</h1>
      <p class="lede">
        Clerk {@clerk} keeps three {@craft} tape lines at Mohe. A new aurora
        line pushes QNH off the end.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button id="prepend-aurora" type="button" phx-click="prepend_aurora">
        Prepend aurora
      </button>

      <button id="append-aurora" type="button" phx-click="append_aurora">
        Append aurora; keep the last three
      </button>

      <div id="tapes" phx-update="stream">
        <p :for={{id, tape} <- @streams.tapes} id={id}>{tape.body}</p>
      </div>
    </Layouts.app>
    """
  end
end
