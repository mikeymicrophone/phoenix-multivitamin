# Async assigns · 03 · Quetta ok board
#
# Teaches:
# - The ok tuple fills the assign result
# - @qnh.ok? is the gate the board reads

defmodule PhoenixMultivitaminWeb.QuettaOkBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Quetta ok board")
     |> assign(:clerk, "Zarmina")
     |> assign(:craft, "Ilyushin Il-18")
     |> assign_async(:qnh, fn -> {:ok, %{qnh: 1019}} end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 03 · Quetta ok board
      </p>

      <h1>Quetta ok board</h1>
      <p class="lede">
        Clerk {@clerk} waits for QNH on the {@craft}. The ok tuple fills
        the board.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="qnh-ok">{if @qnh.ok?, do: "ok", else: "pending"}</p>
      <p :if={@qnh.ok?} id="qnh-value">{@qnh.result}</p>
    </Layouts.catalog>
    """
  end
end
