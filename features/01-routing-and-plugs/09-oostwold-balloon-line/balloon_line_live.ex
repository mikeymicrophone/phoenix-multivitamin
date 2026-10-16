# Routing and plugs · 09 · Oostwold balloon line
#
# Teaches:
# - assign/3 is for the template; put_private/3 is for plugs talking to each other

defmodule PhoenixMultivitaminWeb.OostwoldBalloonLineLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Oostwold balloon line")
     |> assign(:field, "Oostwold balloon meadow")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 09 · Oostwold balloon line
      </p>

      <h1>Oostwold balloon line</h1>
      <p class="lede">
        Cameron balloons line up off {@field}. The launch code is private
        between plugs; the balloon name is an assign the board is allowed to show.
      </p>

      <div class="watch-switcher">
        <.link id="open-line" href={~p"/features/01-routing-and-plugs/09-oostwold-balloon-line/line"}>
          Walk the balloon line
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
