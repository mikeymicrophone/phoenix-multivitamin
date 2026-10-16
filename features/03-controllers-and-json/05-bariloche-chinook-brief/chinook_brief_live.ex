# Controllers and JSON · 05 · Bariloche Chinook brief
#
# Teaches:
# - put_status/2 then render/3 still sends a body

defmodule PhoenixMultivitaminWeb.BarilocheChinookBriefLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Bariloche Chinook brief")
     |> assign(:station, "San Carlos de Bariloche")
     |> assign(:person, "Sofía")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 05 · Bariloche Chinook brief
      </p>

      <h1>Bariloche Chinook brief</h1>
      <p class="lede">
        Officer {@person} accepts a CH-47 Chinook mountain brief at {@station}.
        The desk answers <code>202 Accepted</code> and still draws the brief body.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-brief"
          href={~p"/features/03-controllers-and-json/05-bariloche-chinook-brief/brief"}
        >
          Open the accepted brief
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
