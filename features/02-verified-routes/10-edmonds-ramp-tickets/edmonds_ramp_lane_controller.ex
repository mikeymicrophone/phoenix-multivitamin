# Verified routes · 10 · Edmonds ramp tickets
#
# Teaches:
# - Inside a forwarded router, ~p is verified against that router, not the main one
# - ~p"/lane/2" is unprefixed; path(conn, ~p"/lane/2") adds conn.script_name
# - The main app writes the forward prefix into ~p so the catalog can link here

defmodule PhoenixMultivitaminWeb.EdmondsRampLaneController do
  @moduledoc false
  use Phoenix.Controller, formats: [:html]

  import Plug.Conn

  use Phoenix.VerifiedRoutes,
    endpoint: PhoenixMultivitaminWeb.Endpoint,
    router: PhoenixMultivitaminWeb.EdmondsRampKiosk

  def show(conn, %{"lane" => lane}) do
    local = ~p"/lane/#{lane}"
    prefixed = path(conn, ~p"/lane/#{lane}")

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, """
    <!DOCTYPE html>
    <html>
      <body>
        <p id="lane-name">Lane #{lane} ticket window</p>
        <p id="local-kiosk-path">#{local}</p>
        <p id="prefixed-kiosk-path">#{prefixed}</p>
        <p id="script-name">#{Enum.join(conn.script_name, "/")}</p>
      </body>
    </html>
    """)
  end
end
