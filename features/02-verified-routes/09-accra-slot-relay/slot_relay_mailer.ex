# Verified routes · 09 · Accra slot relay
#
# Teaches:
# - A mailer can use Phoenix.VerifiedRoutes and url(~p"...") with no conn
# - The HTML body interpolates the same verified URL a LiveView would
# - url/1 is the right helper for email: a path is not clickable off-box

defmodule PhoenixMultivitaminWeb.AccraSlotRelayMailer do
  @moduledoc false
  import Swoosh.Email

  alias PhoenixMultivitamin.Mailer
  alias PhoenixMultivitaminWeb.AccraSlotRelayHTML

  use PhoenixMultivitaminWeb, :verified_routes

  def board_url do
    url(~p"/features/02-verified-routes/09-accra-slot-relay")
  end

  def deliver_slot_watch(clerk_name, clerk_email) do
    board_url = board_url()

    html =
      %{clerk: clerk_name, board_url: board_url}
      |> AccraSlotRelayHTML.watch_notice()
      |> Phoenix.HTML.Safe.to_iodata()
      |> IO.iodata_to_binary()

    email =
      new()
      |> to({clerk_name, clerk_email})
      |> from({"Accra Kotoka slot board", "slots@kotoka.gov.gh"})
      |> subject("Slot watch for #{clerk_name}")
      |> html_body(html)
      |> text_body("The slot watch is posted at #{board_url}")

    {:ok, _metadata} = Mailer.deliver(email)
    {:ok, email}
  end
end
