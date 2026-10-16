# Controllers and JSON · 01 · Queenstown METAR desk
#
# Teaches:
# - One controller serves HTML through render/3 and JSON through json/2
# - The JSON action never asks the HTML view for a template

defmodule PhoenixMultivitaminWeb.QueenstownMetarDeskController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @metar %{
    station: "NZQN",
    observer: "Kahu",
    wind: "32015G28KT",
    visibility: "9999",
    weather: "VCSH",
    cloud: "FEW025 SCT040",
    temperature: "12/04",
    qnh: "1008",
    craft: "King Air 200"
  }

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Queenstown METAR desk")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:metar, @metar)
    |> render(:show)
  end

  def export(conn, _params) do
    json(conn, %{metar: @metar, format: "json"})
  end
end
