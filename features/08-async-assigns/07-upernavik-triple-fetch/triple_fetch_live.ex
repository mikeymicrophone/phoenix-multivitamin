# Async assigns · 07 · Upernavik triple fetch
#
# Teaches:
# - Several async assigns in flight together
# - One function returns every key

defmodule PhoenixMultivitaminWeb.UpernavikTripleFetchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Upernavik triple fetch")
     |> assign(:clerk, "Ivalu")
     |> assign(:craft, "Dash 8-200")
     |> assign_async([:wind, :temp, :qnh], fn ->
       {:ok, %{wind: "04018KT", temp: -22, qnh: 998}}
     end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 07 · Upernavik triple fetch
      </p>

      <h1>Upernavik triple fetch</h1>
      <p class="lede">
        Clerk {@clerk} pulls wind, temperature, and QNH for the {@craft} in one async function.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={not @wind.ok?} id="triple-loading">
        Triple fetch still out over Baffin Bay.
      </p>
      <p :if={@wind.ok?} id="wind-value">{@wind.result}</p>
      <p :if={@temp.ok?} id="temp-value">{@temp.result}</p>
      <p :if={@qnh.ok?} id="qnh-value">{@qnh.result}</p>
    </Layouts.catalog>
    """
  end
end
