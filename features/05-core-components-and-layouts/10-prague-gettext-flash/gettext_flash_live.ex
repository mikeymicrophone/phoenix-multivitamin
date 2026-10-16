# Core components and layouts · 10 · Prague gettext flash
#
# Teaches:
# - gettext strings inside core flash copy
# - put_flash can carry a gettext msgid the layout then paints

defmodule PhoenixMultivitaminWeb.PragueGettextFlashLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Prague gettext flash")
     |> assign(:clerk, "Jana")}
  end

  @impl true
  def handle_event("hold_short", _params, socket) do
    {:noreply, put_flash(socket, :info, gettext("Hold short of the threshold"))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 10 · Prague gettext flash
      </p>

      <h1>Prague gettext flash</h1>
      <p class="lede">
        Clerk {@clerk} posts a hold-short at Václav Havel. The flash string is <code>gettext/1</code>. The layout flash group already gettexts its own
        reconnect copy.
      </p>

      <button id="hold-short" type="button" phx-click="hold_short">Hold short</button>
    </Layouts.catalog>
    """
  end
end
