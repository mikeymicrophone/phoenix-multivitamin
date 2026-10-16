# Async assigns · 02 · Mawlamyine monsoon loading
#
# Teaches:
# - The loading slot of <.async_result>
# - The sounding stays out until render_async

defmodule PhoenixMultivitaminWeb.MawlamyineMonsoonLoadingLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Mawlamyine monsoon loading", "Su", "Fokker 70")
     |> assign_async(:sounding, fn -> {:ok, %{sounding: "broken 012, rain"}} end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 02 · Mawlamyine monsoon loading
      </p>

      <h1>Mawlamyine monsoon loading</h1>
      <p class="lede">
        Clerk {@clerk} waits on a monsoon sounding for the {@craft}. The
        loading slot paints until the task returns.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <.async_result :let={sounding} assign={@sounding}>
        <:loading>
          <p id="sounding-loading">Sounding still out over the Salween.</p>
        </:loading>
        <:failed :let={_reason}>
          <p id="sounding-failed">Sounding failed.</p>
        </:failed>
        <p id="sounding-value">{sounding}</p>
      </.async_result>
    </Layouts.app>
    """
  end
end
