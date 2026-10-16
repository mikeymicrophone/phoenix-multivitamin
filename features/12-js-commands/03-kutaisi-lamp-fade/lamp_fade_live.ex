# JS commands · 03 · Kutaisi lamp fade
#
# Teaches:
# - JS.transition/1 for a lamp that fades

defmodule PhoenixMultivitaminWeb.KutaisiLampFadeLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Kutaisi lamp fade")
     |> assign(:clerk, "Tamari")
     |> assign(:craft, "Embraer ERJ-145")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 03 · Kutaisi lamp fade
      </p>

      <h1>Kutaisi lamp fade</h1>
      <p class="lede">
        Clerk {@clerk} fades the threshold lamp on the {@craft}.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button
        id="fade-lamp"
        type="button"
        phx-click={JS.transition("fade-lamp", to: "#threshold-lamp")}
      >
        Fade lamp
      </button>

      <p id="threshold-lamp">Threshold bar lit.</p>
    </Layouts.catalog>
    """
  end
end
