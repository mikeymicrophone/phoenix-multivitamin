# Verified routes · 13 · Fort Worden guard house
#
# Teaches:
# - The mailer uses the same ~p paths as the LiveView, wrapped in url/1

defmodule PhoenixMultivitaminWeb.FortWordenGuardHouseMailer do
  @moduledoc false
  import Swoosh.Email

  alias PhoenixMultivitamin.Mailer
  alias PhoenixMultivitaminWeb.FortWordenGuardHouseHTML

  use PhoenixMultivitaminWeb, :verified_routes

  def board_url, do: url(~p"/features/02-verified-routes/13-fort-worden-guard-house")

  def pass_url(pass) do
    url(~p"/features/02-verified-routes/13-fort-worden-guard-house/passes/#{pass}")
  end

  def deliver_pass(sentry_name, sentry_email, pass) do
    board_url = board_url()
    pass_url = pass_url(pass)

    html =
      %{sentry: sentry_name, board_url: board_url, pass_url: pass_url}
      |> FortWordenGuardHouseHTML.pass_notice()
      |> Phoenix.HTML.Safe.to_iodata()
      |> IO.iodata_to_binary()

    new()
    |> to({sentry_name, sentry_email})
    |> from({"Fort Worden guard house", "sentry@fortworden.wa.gov"})
    |> subject("Battery #{pass} pass for #{sentry_name}")
    |> html_body(html)
    |> text_body("Board #{board_url} · pass #{pass_url}")
    |> Mailer.deliver()
  end
end
