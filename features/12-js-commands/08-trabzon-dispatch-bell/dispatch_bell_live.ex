# JS commands · 08 · Trabzon dispatch bell
#
# Teaches:
# - JS.dispatch/1 of a custom event

defmodule PhoenixMultivitaminWeb.TrabzonDispatchBellLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Trabzon dispatch bell")
     |> assign(:clerk, "Aylin")
     |> assign(:craft, "Airbus A310")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 08 · Trabzon dispatch bell
      </p>

      <h1>Trabzon dispatch bell</h1>
      <p class="lede">
        Clerk {@clerk} dispatches a chime event toward the {@craft} bell.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button
        id="strike-chime"
        type="button"
        phx-click={JS.dispatch("fuel-chime", to: "#chime-bell", detail: %{stand: "east"})}
      >
        Strike chime
      </button>

      <p id="chime-bell">Pontic chime.</p>
    </Layouts.catalog>
    """
  end
end
