# Verified routes · 09 · Point Robinson bell relay
#
# Teaches:
# - A mailer can use Phoenix.VerifiedRoutes and url(~p"...") with no conn
# - The HTML body interpolates the same verified URL a LiveView would
# - url/1 is the right helper for email: a path is not clickable off-box

defmodule PhoenixMultivitaminWeb.PointRobinsonBellRelayMailer do
  @moduledoc false
  import Swoosh.Email

  alias PhoenixMultivitamin.Mailer
  alias PhoenixMultivitaminWeb.PointRobinsonBellRelayHTML

  use PhoenixMultivitaminWeb, :verified_routes

  def board_url do
    url(~p"/features/02-verified-routes/09-point-robinson-bell-relay")
  end

  def deliver_bell_watch(keeper_name, keeper_email) do
    board_url = board_url()

    html =
      %{keeper: keeper_name, board_url: board_url}
      |> PointRobinsonBellRelayHTML.watch_notice()
      |> Phoenix.HTML.Safe.to_iodata()
      |> IO.iodata_to_binary()

    new()
    |> to({keeper_name, keeper_email})
    |> from({"Point Robinson Light", "bell@pointrobinson.wa.gov"})
    |> subject("Bell watch for #{keeper_name}")
    |> html_body(html)
    |> text_body("The bell watch is posted at #{board_url}")
    |> Mailer.deliver()
  end
end
