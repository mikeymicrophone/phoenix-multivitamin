# Routing and plugs · 05 · Shannon avgas office
#
# Teaches:
# - Plug options stay next to the controller that uses them
# - init/1 receives the keyword list; call/2 receives what init returned

defmodule PhoenixMultivitaminWeb.ShannonAvgasOfficeLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Shannon avgas office")
     |> assign(:apron, "Shannon")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 05 · Shannon avgas office
      </p>

      <h1>Shannon avgas office</h1>
      <p class="lede">
        Bowsers off {@apron} carry 100LL onto the GA apron.
        The office plug takes apron, grade, and bowser as options.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-bowser"
          href={~p"/features/01-routing-and-plugs/05-shannon-avgas-office/bowser"}
        >
          Open the avgas office
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
