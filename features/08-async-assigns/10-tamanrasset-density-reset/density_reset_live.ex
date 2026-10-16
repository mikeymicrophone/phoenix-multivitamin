# Async assigns · 10 · Tamanrasset density reset
#
# Teaches:
# - reset: true clears the previous result while loading
# - A later assign_async fills a new card

defmodule PhoenixMultivitaminWeb.TamanrassetDensityResetLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Tamanrasset density reset", "Yasmina", "CASA C-295")
     |> assign(:oat_c, 34)
     |> fetch_card(reset?: false)}
  end

  @impl true
  def handle_event("recompute_card", _params, socket) do
    {:noreply,
     socket
     |> assign(:oat_c, 41)
     |> fetch_card(reset?: true)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 10 · Tamanrasset density reset
      </p>

      <h1>Tamanrasset density reset</h1>
      <p class="lede">
        Clerk {@clerk} recomputes density altitude for the {@craft}. <code>reset: true</code>
        clears the last card while the next one loads.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p :if={@card.loading} id="card-loading">Density card resetting.</p>
      <p :if={@card.ok?} id="card-value">{@card.result}</p>

      <button id="recompute-card" type="button" phx-click="recompute_card">Recompute</button>
    </Layouts.app>
    """
  end

  defp fetch_card(socket, reset?: reset?) do
    oat = socket.assigns.oat_c

    assign_async(
      socket,
      :card,
      fn -> {:ok, %{card: "DA #{4100 + oat * 10} ft"}} end,
      reset: reset?
    )
  end
end
