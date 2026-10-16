# LiveComponents · 10 · Rankin Inlet myself
#
# Teaches:
# - The difference between myself and the parent pid

defmodule PhoenixMultivitaminWeb.RankinInletMyselfLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.RankinInletMyselfCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Rankin Inlet myself")
     |> assign(:clerk, "Tapiri")
     |> assign(:craft, "Hawker 800XP")
     |> assign(:parent_heard, "quiet")}
  end

  @impl true
  def handle_info({:cell_pid, :parent}, socket) do
    {:noreply, assign(socket, :parent_heard, "heard")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveComponents · 10 · Rankin Inlet myself
      </p>

      <h1>Rankin Inlet myself</h1>
      <p class="lede">
        Clerk {@clerk} stamps the {@craft} cell through @myself, then pings
        the parent with self().
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="parent-heard">{@parent_heard}</p>

      <.live_component module={RankinInletMyselfCell} id="myself-cell" />
    </Layouts.catalog>
    """
  end
end
