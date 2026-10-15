# Verified routes · 05 · West Point current card
#
# Teaches:
# - redirect(to: ~p"...") from a controller action
# - Query strings on the redirect target are still verified paths

defmodule PhoenixMultivitaminWeb.WestPointCurrentCardController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def drift(conn, _params) do
    redirect(conn,
      to:
        ~p"/features/02-verified-routes/05-west-point-current-card?#{[set: "ebb", knots: "1.4"]}"
    )
  end

  def drift_path, do: ~p"/features/02-verified-routes/05-west-point-current-card/drift"
end
