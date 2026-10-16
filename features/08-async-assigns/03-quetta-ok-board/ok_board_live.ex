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
     |> assign_scenario("Quetta ok board", "Zarmina", "Ilyushin Il-18")
     |> assign_async(:qnh, fn -> {:ok, %{qnh: 1019}} end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 03 · Quetta ok board
      </p>

      <h1>Quetta ok board</h1>
      <p class="lede">
        Clerk {@clerk} waits for QNH on the {@craft}. The ok tuple fills
        the board.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p id="qnh-ok">{if @qnh.ok?, do: "ok", else: "pending"}</p>
      <p :if={@qnh.ok?} id="qnh-value">{@qnh.result}</p>
    </Layouts.app>
    """
  end
end
