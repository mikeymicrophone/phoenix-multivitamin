# LiveComponents · 06 · Murmansk batch cell
#
# Teaches:
# - update_many/1 is the batch callback (preload/1 is gone)

defmodule PhoenixMultivitaminWeb.MurmanskBatchCell do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_component

  @readings %{"kola" => "1018", "teriberka" => "1009", "lovozero" => "1011"}

  @impl true
  def update_many(assigns_sockets) do
    batch_size = length(assigns_sockets)

    Enum.map(assigns_sockets, fn {assigns, socket} ->
      socket
      |> assign(assigns)
      |> assign(:qnh, Map.fetch!(@readings, assigns.id))
      |> assign(:batch_size, batch_size)
    end)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <p id={"qnh-" <> @id}>{@qnh}</p>
      <p id={"batch-" <> @id}>{@batch_size}</p>
    </div>
    """
  end
end
