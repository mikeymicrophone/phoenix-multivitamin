# Streams · 01 · Resolute departure stream
#
# Teaches:
# - stream/4 replacing an assign list

defmodule PhoenixMultivitaminWeb.ResoluteDepartureStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    departures = [
      %{id: "polaris", stand: "Polaris", wind: "34028KT"}
    ]

    {:ok,
     socket
     |> assign_scenario("Resolute departure stream", "Aaluk", "DHC-5 Buffalo")
     |> stream(:departures, departures)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 01 · Resolute departure stream
      </p>

      <h1>Resolute departure stream</h1>
      <p class="lede">
        Clerk {@clerk} keeps {@craft} departures at Resolute in a stream,
        not an assign list.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <div id="departures" phx-update="stream">
        <div :for={{id, row} <- @streams.departures} id={id}>
          <span id={"stand-" <> row.id}>{row.stand}</span>
          <span id={"wind-" <> row.id}>{row.wind}</span>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
