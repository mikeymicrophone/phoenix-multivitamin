defmodule PhoenixMultivitaminWeb.PointRobinsonBellRelayHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def watch_notice(assigns) do
    ~H"""
    <p id="bell-mail">
      {@keeper}, the bell watch is posted at <a id="bell-mail-link" href={@board_url}>{@board_url}</a>.
      Strike once at the quarter for Maury Island.
    </p>
    """
  end
end
