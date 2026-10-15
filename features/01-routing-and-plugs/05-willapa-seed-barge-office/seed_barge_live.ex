# Routing and plugs · 05 · Willapa seed barge office
#
# Teaches:
# - Plug options stay next to the controller that uses them
# - init/1 receives the keyword list; call/2 receives what init returned

defmodule PhoenixMultivitaminWeb.WillapaSeedBargeOfficeLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Willapa seed barge office")
     |> assign(:landing, "Nahcotta")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 05 · Willapa seed barge office
      </p>

      <h1>Willapa seed barge office</h1>
      <p class="lede">
        Seed barges off {@landing} carry Pacific oyster spat onto Willapa Bay.
        The office plug takes landing, crop, and barge as options.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-office"
          href={~p"/features/01-routing-and-plugs/05-willapa-seed-barge-office/office"}
        >
          Open the barge office
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
