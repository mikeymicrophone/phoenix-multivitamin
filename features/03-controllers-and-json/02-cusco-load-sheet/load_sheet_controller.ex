# Controllers and JSON · 02 · Cusco load sheet
#
# Teaches:
# - json/2 sends a domain map
# - put_status/2 before json/2 is the status the client sees (201 Created)

defmodule PhoenixMultivitaminWeb.CuscoLoadSheetController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, _params) do
    sheet = %{
      station: "SPZO",
      loader: "Inti",
      craft: "Boeing 737-700",
      takeoff_weight_kg: 62_400,
      fuel_kg: 8_200,
      mac_percent: "27.4",
      density_altitude_ft: 11_150
    }

    conn
    |> put_status(:created)
    |> json(%{load_sheet: sheet, status: "accepted"})
  end
end
