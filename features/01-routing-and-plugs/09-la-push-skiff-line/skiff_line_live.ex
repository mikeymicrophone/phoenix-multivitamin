# Routing and plugs · 09 · La Push skiff line
#
# Teaches:
# - assign/3 is for the template; put_private/3 is for plugs talking to each other

defmodule PhoenixMultivitaminWeb.LaPushSkiffLineLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "La Push skiff line")
     |> assign(:beach, "Rialto Beach")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 09 · La Push skiff line
      </p>

      <h1>La Push skiff line</h1>
      <p class="lede">
        Quileute surf skiffs line up off {@beach}. The launch code is private
        between plugs; the skiff name is an assign the board is allowed to show.
      </p>

      <div class="watch-switcher">
        <.link id="open-line" href={~p"/features/01-routing-and-plugs/09-la-push-skiff-line/line"}>
          Walk the skiff line
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
