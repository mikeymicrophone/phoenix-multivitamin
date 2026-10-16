# Streams · 10 · Tiksi hoist cell
#
# Teaches:
# - Each streamed row is a LiveComponent

defmodule PhoenixMultivitaminWeb.TiksiHoistCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <span id={"hoist-" <> @hoist.id}>{@hoist.site}</span>
    </div>
    """
  end
end
