# JS commands · 07 · Sinop focus pad
#
# Teaches:
# - JS.focus/1 and JS.focus_first/1

defmodule PhoenixMultivitaminWeb.SinopFocusPadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Sinop focus pad")
     |> assign(:clerk, "Elif")
     |> assign(:craft, "Cessna Citation CJ3")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 07 · Sinop focus pad
      </p>

      <h1>Sinop focus pad</h1>
      <p class="lede">
        Clerk {@clerk} focuses the {@craft} slot box, then the first pad field.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="focus-slot" type="button" phx-click={JS.focus(to: "#slot-input")}>
        Focus slot
      </button>
      <button id="focus-first-pad" type="button" phx-click={JS.focus_first(to: "#pad-fields")}>
        Focus first pad
      </button>

      <div id="pad-fields">
        <input id="slot-input" type="text" name="slot" value="east" />
        <input id="qnh-input" type="text" name="qnh" value="1013" />
      </div>
    </Layouts.catalog>
    """
  end
end
