# Streams · 07 · Osh filter reset
#
# Teaches:
# - stream/4 with reset: true after a filter changes

defmodule PhoenixMultivitaminWeb.OshFilterResetLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @legs [
    %{id: "fergana", name: "Fergana", kind: "east"},
    %{id: "andijan", name: "Andijan", kind: "east"},
    %{id: "khujand", name: "Khujand", kind: "west"}
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Osh filter reset")
     |> assign(:clerk, "Aigul")
     |> assign(:craft, "Antonov An-28")
     |> assign(:filter, "all")
     |> stream(:legs, @legs)}
  end

  @impl true
  def handle_event("filter_east", _params, socket) do
    legs = Enum.filter(@legs, &(&1.kind == "east"))

    {:noreply,
     socket
     |> assign(:filter, "east")
     |> stream(:legs, legs, reset: true)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 07 · Osh filter reset
      </p>

      <h1>Osh filter reset</h1>
      <p class="lede">
        Clerk {@clerk} filters {@craft} legs at Osh and resets the stream.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="filter-name">{@filter}</p>

      <button id="filter-east" type="button" phx-click="filter_east">
        East legs
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
