# Verified routes · 08 · Smith Island tide drum
#
# Teaches:
# - put_router_url/2 on the conn makes url(conn, ~p"...") use that host
# - The path from ~p is unchanged; only the scheme and host come from the conn

defmodule PhoenixMultivitaminWeb.SmithIslandTideDrumController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def island_host(conn, _params) do
    conn = put_router_url(conn, "https://tidedrum.smithisland.wa.gov")

    text(conn, url(conn, ~p"/features/02-verified-routes/08-smith-island-tide-drum"))
  end

  def island_host_path, do: ~p"/features/02-verified-routes/08-smith-island-tide-drum/island-host"
end
