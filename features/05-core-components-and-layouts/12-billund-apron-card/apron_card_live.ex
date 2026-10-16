# Core components and layouts · 12 · Billund apron card
#
# Teaches:
# - The shared layout mentions no scenario name
# - Station names live only on this page

defmodule PhoenixMultivitaminWeb.BillundApronCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Billund apron card")
     |> assign(:marshal, "Mads")
     |> assign(:craft, "CRJ900")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 12 · Billund apron card
      </p>

      <h1>Billund apron card</h1>
      <p class="lede">
        Marshal {@marshal} parks a {@craft} on the LEGO apron. The catalog brand
        still says only Phoenix Multivitamin. Billund lives on this card.
      </p>

      <p id="marshal-name">{@marshal}</p>
      <p id="craft-name">{@craft}</p>
    </Layouts.catalog>
    """
  end
end
