defmodule PhoenixMultivitaminWeb.FortWordenGuardHouseHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def pass_notice(assigns) do
    ~H"""
    <p id="guard-mail">
      {@sentry}, your pass is posted at <a id="guard-mail-link" href={@board_url}>{@board_url}</a>
      and the paper pass hangs at <a id="guard-mail-pass" href={@pass_url}>{@pass_url}</a>.
    </p>
    """
  end
end
