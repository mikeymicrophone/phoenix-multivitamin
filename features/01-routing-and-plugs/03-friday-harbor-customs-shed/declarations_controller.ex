# Routing and plugs · 03 · Friday Harbor customs shed
#
# Teaches:
# - Sibling scopes share one controller and split a plug stack by lane
# - resources/4 draws index and show under each prefix
# - Path params arrive as strings, even when the declaration number looks numeric

defmodule PhoenixMultivitaminWeb.FridayHarborDeclarationsController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @arrivals %{
    "coho" => %{vessel: "MV Coho", from: "Victoria Inner Harbour", cargo: "walk-on passengers"},
    "17" => %{vessel: "Harbor Patrol 17", from: "Turn Island", cargo: "empty fuel cans"}
  }

  @departures %{
    "osprey" => %{vessel: "whale-watch Osprey", to: "Lime Kiln", cargo: "day passengers"},
    "marigold" => %{
      vessel: "troller Marigold",
      to: "Cape Flattery grounds",
      cargo: "ice and bait"
    }
  }

  def index(conn, _params) do
    declarations = declarations_for(conn.assigns.lane)

    conn
    |> assign(:page_title, "Friday Harbor customs shed")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:declarations, declarations)
    |> render(:index)
  end

  def show(conn, %{"id" => id}) do
    declaration = Map.fetch!(declarations_for(conn.assigns.lane), id)

    conn
    |> assign(:page_title, "Friday Harbor customs shed")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:declaration_id, id)
    |> assign(:declaration_id_is_binary, is_binary(id))
    |> assign(:declaration, declaration)
    |> render(:show)
  end

  defp declarations_for(:arrivals), do: @arrivals
  defp declarations_for(:departures), do: @departures
end
