# Verified routes · 13 · Luqa QRA guard house
#
# Teaches:
# - The gate action redirects to the same ~p the LiveView and mailer use

defmodule PhoenixMultivitaminWeb.LuqaQraGuardHouseController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def gate(conn, _params) do
    redirect(conn,
      to:
        ~p"/features/02-verified-routes/13-luqa-qra-guard-house?#{[watch: "evening", gate: "open"]}"
    )
  end

  def gate_path, do: ~p"/features/02-verified-routes/13-luqa-qra-guard-house/gate"
end
