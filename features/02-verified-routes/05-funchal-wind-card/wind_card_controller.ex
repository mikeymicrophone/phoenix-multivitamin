# Verified routes · 05 · Funchal wind card
#
# Teaches:
# - redirect(to: ~p"...") from a controller action
# - Query strings on the redirect target are still verified paths

defmodule PhoenixMultivitaminWeb.FunchalWindCardController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def drift(conn, _params) do
    redirect(conn,
      to:
        ~p"/features/02-verified-routes/05-funchal-wind-card?#{[set: "cross", knots: "18"]}"
    )
  end

  def drift_path, do: ~p"/features/02-verified-routes/05-funchal-wind-card/drift"
end
