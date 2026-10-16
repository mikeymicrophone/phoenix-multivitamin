# Async assigns · 01 · Puerto Natales wind fetch
#
# Teaches:
# - assign_async/3 started from mount
# - The task starts only when the socket is connected
# - async_result slots render loading, failure, and the bound wind value

defmodule PhoenixMultivitaminWeb.PuertoNatalesWindFetchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Puerto Natales wind fetch", "Esperanza", "Pilatus PC-6")
     |> assign_async(:wind, fn -> {:ok, %{wind: "32022G34KT"}} end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 01 · Puerto Natales wind fetch
      </p>

      <h1>Puerto Natales wind fetch</h1>
      <p class="lede">
        Clerk {@clerk} fetches wind for the {@craft} without blocking mount.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.async_result :let={wind} assign={@wind}>
        <:loading>
          <p id="wind-loading">Wind still out on the steppe.</p>
        </:loading>
        <:failed>
          <p id="wind-failed">Wind fetch failed. Reopen the Puerto Natales board to retry.</p>
        </:failed>
        <p id="wind-value">{wind}</p>
      </.async_result>
    </Layouts.app>
    """
  end
end
