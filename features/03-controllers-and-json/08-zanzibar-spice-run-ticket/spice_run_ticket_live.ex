# Controllers and JSON · 08 · Zanzibar spice-run ticket
#
# Teaches:
# - A JSON index renders a collection without an HTML view

defmodule PhoenixMultivitaminWeb.ZanzibarSpiceRunTicketLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Zanzibar spice-run ticket")
     |> assign(:station, "Abeid Amani Karume")
     |> assign(:person, "Asha")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Controllers and JSON · 08 · Zanzibar spice-run ticket
      </p>

      <h1>Zanzibar spice-run ticket</h1>
      <p class="lede">
        Clerk {@person} lists Let L-410 clove and cinnamon tickets at {@station}. <code>index/2</code>
        is a JSON array. There is no HTML view module for the list.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-tickets"
          href={~p"/features/03-controllers-and-json/08-zanzibar-spice-run-ticket/tickets"}
        >
          List the spice-run tickets
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
