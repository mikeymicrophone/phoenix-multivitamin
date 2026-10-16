# Controllers and JSON · 08 · Zanzibar spice-run ticket
#
# Teaches:
# - json/2 can render a collection index
# - The payload is a list of domain maps, not a view template

defmodule PhoenixMultivitaminWeb.ZanzibarSpiceRunTicketController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @tickets [
    %{id: "clove-06", clerk: "Asha", craft: "Let L-410", cargo: "clove sacks", kg: 420},
    %{id: "cinnamon-11", clerk: "Asha", craft: "Let L-410", cargo: "cinnamon bales", kg: 310},
    %{id: "nutmeg-02", clerk: "Asha", craft: "Let L-410", cargo: "nutmeg crates", kg: 180}
  ]

  def index(conn, _params) do
    json(conn, %{station: "HTZA", clerk: "Asha", tickets: @tickets})
  end
end
