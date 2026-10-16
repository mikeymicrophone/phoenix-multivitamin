# Async assigns · 01 · Puerto Natales wind fetch
#
# Teaches:
# - assign_async/3 started from mount
# - The task starts only when the socket is connected

defmodule PhoenixMultivitaminWeb.PuertoNatalesWindFetchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Puerto Natales wind fetch")
     |> assign(:clerk, "Esperanza")
     |> assign(:craft, "Pilatus PC-6")
     |> assign_async(:wind, fn -> {:ok, %{wind: "32022G34KT"}} end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 01 · Puerto Natales wind fetch
      </p>

      <h1>Puerto Natales wind fetch</h1>
      <p class="lede">
        Clerk {@clerk} fetches wind for the {@craft} without blocking mount.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={@wind.loading} id="wind-loading">Wind still out on the steppe.</p>
      <p :if={@wind.ok?} id="wind-value">{@wind.result}</p>
    </Layouts.catalog>
    """
  end
end
