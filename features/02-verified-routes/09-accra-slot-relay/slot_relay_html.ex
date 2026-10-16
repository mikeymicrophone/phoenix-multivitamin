defmodule PhoenixMultivitaminWeb.AccraSlotRelayHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def watch_notice(assigns) do
    ~H"""
    <p id="slot-mail">
      {@clerk}, the slot watch is posted at <a id="slot-mail-link" href={@board_url}>{@board_url}</a>.
      Hold the 777-300ER at the quarter for Kotoka.
    </p>
    """
  end
end
