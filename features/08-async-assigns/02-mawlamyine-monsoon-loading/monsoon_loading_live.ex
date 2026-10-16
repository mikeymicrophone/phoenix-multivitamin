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
     |> assign(:page_title, "Mawlamyine monsoon loading")
     |> assign(:clerk, "Su")
     |> assign(:craft, "Fokker 70")
     |> assign_async(:sounding, fn -> {:ok, %{sounding: "broken 012, rain"}} end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 02 · Mawlamyine monsoon loading
      </p>

      <h1>Mawlamyine monsoon loading</h1>
      <p class="lede">
        Clerk {@clerk} waits on a monsoon sounding for the {@craft}. The
        loading slot paints until the task returns.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.async_result :let={sounding} assign={@sounding}>
        <:loading>
          <p id="sounding-loading">Sounding still out over the Salween.</p>
        </:loading>
        <:failed :let={_reason}>
          <p id="sounding-failed">Sounding failed.</p>
        </:failed>
        <p id="sounding-value">{sounding}</p>
      </.async_result>
    </Layouts.catalog>
    """
  end
end
