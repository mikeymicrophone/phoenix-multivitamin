# Routing and plugs · 03 · Incheon bonded shed
#
# Teaches:
# - Sibling scopes share one controller and split a plug stack by lane
# - resources/4 draws index and show under each prefix
# - Path params arrive as strings, even when the declaration number looks numeric

defmodule PhoenixMultivitaminWeb.IncheonDeclarationsController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @arrivals %{
    "ke" => %{craft: "KE pallet run", from: "Narita bonded", cargo: "duty-free spirits"},
    "17" => %{craft: "ULD train 17", from: "Incheon cargo city", cargo: "empty AKE cans"}
  }

  @departures %{
    "oz" => %{craft: "OZ re-export van", to: "Xi'an bonded", cargo: "chip trays"},
    "hl" => %{
      craft: "Hanjin late pallet",
      to: "Busan hinterland",
      cargo: "spare inverters"
    }
  }

  def index(conn, _params) do
    declarations = declarations_for(conn.assigns.lane)

    conn
    |> assign(:page_title, "Incheon bonded shed")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:declarations, declarations)
    |> render(:index)
  end

  def show(conn, %{"id" => id}) do
    declaration = Map.fetch!(declarations_for(conn.assigns.lane), id)

    conn
    |> assign(:page_title, "Incheon bonded shed")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:declaration_id, id)
    |> assign(:declaration_id_is_binary, is_binary(id))
    |> assign(:declaration, declaration)
    |> render(:show)
  end

  defp declarations_for(:arrivals), do: @arrivals
  defp declarations_for(:departures), do: @departures
end
