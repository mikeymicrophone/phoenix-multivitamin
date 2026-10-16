# Controllers and JSON · 11 · Lhasa oxygen plan
#
# Teaches:
# - send_resp/3 writes the body itself
# - put_resp_content_type/2 makes it text/plain
# - No HTML view and no json/2 run for this action

defmodule PhoenixMultivitaminWeb.LhasaOxygenPlanController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, _params) do
    ticket = """
    LHAS OXYGEN PLAN
    planner=Dawa
    craft=Comac C919
    cabin=8,000 ft
    masks=ready
    """

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, ticket)
  end
end
