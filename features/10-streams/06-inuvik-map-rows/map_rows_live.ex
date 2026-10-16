# Streams · 06 · Inuvik map rows
#
# Teaches:
# - dom_id for a row that is not a schema

defmodule PhoenixMultivitaminWeb.InuvikMapRowsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Inuvik map rows")
     |> assign(:clerk, "Qajaq")
     |> assign(:craft, "DHC-4 Caribou")
     |> stream_configure(:metars, dom_id: &"metar-#{&1.hour}")
     |> stream(:metars, [%{hour: "18z", wind: "31024KT"}])}
  end

  @impl true
  def handle_event("add_21z", _params, socket) do
    {:noreply, stream_insert(socket, :metars, %{hour: "21z", wind: "30018KT"})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 06 · Inuvik map rows
      </p>

      <h1>Inuvik map rows</h1>
      <p class="lede">
        Clerk {@clerk} streams {@craft} METARs that are maps, not schemas.
        The DOM id comes from the hour.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <button id="add-21z" type="button" phx-click="add_21z">Add 21Z</button>

      <div id="metars" phx-update="stream">
        <p :for={{id, metar} <- @streams.metars} id={id}>{metar.hour} {metar.wind}</p>
      </div>
    </Layouts.catalog>
    """
  end
end
