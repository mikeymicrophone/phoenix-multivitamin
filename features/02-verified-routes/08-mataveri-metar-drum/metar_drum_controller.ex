# Verified routes · 08 · Mataveri METAR drum
#
# Teaches:
# - put_router_url/2 on the conn makes url(conn, ~p"...") use that host
# - The path from ~p is unchanged; only the scheme and host come from the conn

defmodule PhoenixMultivitaminWeb.MataveriMetarDrumController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def island_host(conn, _params) do
    conn = put_router_url(conn, "https://metar.mataveri.cl")

    text(conn, url(conn, ~p"/features/02-verified-routes/08-mataveri-metar-drum"))
  end

  def island_host_path, do: ~p"/features/02-verified-routes/08-mataveri-metar-drum/island-host"
end
