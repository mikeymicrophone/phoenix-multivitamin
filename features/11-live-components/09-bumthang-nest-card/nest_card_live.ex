# LiveComponents · 09 · Bumthang nest card
#
# Teaches:
# - A component nested inside another component

defmodule PhoenixMultivitaminWeb.BumthangNestCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.BumthangOuterCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Bumthang nest card")
     |> assign(:clerk, "Dechen")
     |> assign(:craft, "Xian MA60")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 09 · Bumthang nest card
      </p>

      <h1>Bumthang nest card</h1>
      <p class="lede">
        Clerk {@clerk} nests a valley cell inside the {@craft} outer card.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.live_component
        module={BumthangOuterCell}
        id="outer-cell"
        clerk={@clerk}
        valley="Chhume"
      />
    </Layouts.catalog>
    """
  end
end
