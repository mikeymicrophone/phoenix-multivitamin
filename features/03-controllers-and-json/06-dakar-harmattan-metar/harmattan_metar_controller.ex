# Controllers and JSON · 06 · Dakar harmattan METAR
#
# Teaches:
# - One action reads get_format/1 after plug :accepts, ["html", "json"]
# - Accept: application/json selects json; a browser Accept selects html
# - A wild Accept that misses both lists is 406

defmodule PhoenixMultivitaminWeb.DakarHarmattanMetarController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @metar %{
    station: "GOBD",
    observer: "Awa",
    craft: "Boeing 777-200ER",
    wind: "04018KT",
    visibility: "3000",
    weather: "HZ",
    dust: "harmattan"
  }

  def show(conn, _params) do
    case get_format(conn) do
      "json" ->
        json(conn, %{metar: @metar, format: get_format(conn)})

      _ ->
        conn
        |> assign(:page_title, "Dakar harmattan METAR")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> assign(:metar, @metar)
        |> assign(:format_name, get_format(conn))
        |> render(:show)
    end
  end
end
