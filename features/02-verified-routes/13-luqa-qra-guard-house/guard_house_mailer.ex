# Verified routes · 13 · Luqa QRA guard house
#
# Teaches:
# - The mailer uses the same ~p paths as the LiveView, wrapped in url/1

defmodule PhoenixMultivitaminWeb.LuqaQraGuardHouseMailer do
  @moduledoc false
  import Swoosh.Email

  alias PhoenixMultivitamin.Mailer
  alias PhoenixMultivitaminWeb.LuqaQraGuardHouseHTML

  use PhoenixMultivitaminWeb, :verified_routes

  def board_url, do: url(~p"/features/02-verified-routes/13-luqa-qra-guard-house")

  def pass_url(pass) do
    url(~p"/features/02-verified-routes/13-luqa-qra-guard-house/passes/#{pass}")
  end

  def deliver_pass(guard_name, guard_email, pass) do
    board_url = board_url()
    pass_url = pass_url(pass)

    html =
      %{guard: guard_name, board_url: board_url, pass_url: pass_url}
      |> LuqaQraGuardHouseHTML.pass_notice()
      |> Phoenix.HTML.Safe.to_iodata()
      |> IO.iodata_to_binary()

    email =
      new()
      |> to({guard_name, guard_email})
      |> from({"Luqa QRA guard house", "qra@luqa.gov.mt"})
      |> subject("Hangar #{pass} pass for #{guard_name}")
      |> html_body(html)
      |> text_body("Board #{board_url} · pass #{pass_url}")

    {:ok, _metadata} = Mailer.deliver(email)
    {:ok, email}
  end
end
