# Streams · 07 · Osh filter reset
#
# Teaches:
# - stream/4 with reset: true after a filter changes
# - Guarded filter clauses and a filtered Elixir comprehension

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
     |> assign_scenario("Osh filter reset", "Aigul", "Antonov An-28")
     |> assign(:filter, "all")
     |> stream(:legs, @legs)}
  end

  @impl true
  def handle_event("filter_east", %{"kind" => kind}, socket) do
    with {:ok, legs} <- filter_legs(kind) do
      {:noreply,
       socket
       |> assign(:filter, kind)
       |> stream(:legs, legs, reset: true)}
    else
      {:error, :unknown_direction} ->
        {:noreply, put_flash(socket, :error, "Choose an Osh leg direction.")}
    end
  end

  defp filter_legs("all"), do: {:ok, @legs}

  defp filter_legs(kind) when kind in ~w(east west) do
    {:ok, for(%{kind: ^kind} = leg <- @legs, do: leg)}
  end

  defp filter_legs(_kind), do: {:error, :unknown_direction}

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 07 · Osh filter reset
      </p>

      <h1>Osh filter reset</h1>
      <p class="lede">
        Clerk {@clerk} filters {@craft} legs at Osh and resets the stream.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p id="filter-name">{@filter}</p>

      <button
        :for={kind <- ~w(all east west)}
        id={"filter-" <> kind}
        type="button"
        phx-click="filter_east"
        phx-value-kind={kind}
      >
        {String.capitalize(kind)} legs
      </button>

      <div id="legs" phx-update="stream">
        <div :for={{id, leg} <- @streams.legs} id={id}>
          <span id={"leg-" <> leg.id}>{leg.name}</span>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
