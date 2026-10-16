# Async assigns · 13 · Balmaceda capstone desk
#
# Teaches:
# - Capstone: two boards, a failure, and a retry on one desk
# - Wind can succeed while icing stays failed until retry

defmodule PhoenixMultivitaminWeb.BalmacedaCapstoneDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Balmaceda capstone desk", "Pascual", "BAe 146")
     |> assign(:probe_dark?, true)
     |> assign_async(:wind, fn -> {:ok, %{wind: "27028G40KT"}} end)
     |> fetch_icing()}
  end

  @impl true
  def handle_event("retry_icing", _params, socket) do
    {:noreply,
     socket
     |> assign(:probe_dark?, false)
     |> fetch_icing()}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 13 · Balmaceda capstone desk
      </p>

      <h1>Balmaceda capstone desk</h1>
      <p class="lede">
        Clerk {@clerk} keeps wind and icing on the {@craft}. Wind lands.
        Icing fails until retry.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p :if={@wind.ok?} id="wind-value">{@wind.result}</p>
      <p :if={@icing.failed} id="icing-failed">{inspect(@icing.failed)}</p>
      <p :if={@icing.ok?} id="icing-value">{@icing.result}</p>

      <button id="retry-icing" type="button" phx-click="retry_icing">Retry icing</button>
    </Layouts.app>
    """
  end

  defp fetch_icing(socket) do
    dark? = socket.assigns.probe_dark?

    assign_async(socket, :icing, fn ->
      if dark? do
        {:error, :icing_probe_dark}
      else
        {:ok, %{icing: "moderate rime"}}
      end
    end)
  end
end
