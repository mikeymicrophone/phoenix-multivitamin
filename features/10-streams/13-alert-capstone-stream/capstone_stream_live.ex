# Streams · 13 · Alert capstone stream
#
# Teaches:
# - Insert, delete, reset, and an empty apron

defmodule PhoenixMultivitaminWeb.AlertCapstoneStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Alert capstone stream", "Neevee", "Airbus A400M")
     |> reset_board()}
  end

  @impl true
  def handle_event("add_lincoln", _params, socket) do
    {:noreply,
     socket
     |> assign(:apron_count, socket.assigns.apron_count + 1)
     |> stream_insert(:aprons, %{id: "lincoln", name: "Lincoln Sea"})}
  end

  def handle_event("clear_alert", _params, socket) do
    {:noreply,
     socket
     |> assign(:apron_count, socket.assigns.apron_count - 1)
     |> stream_delete(:aprons, %{id: "alert", name: "Alert pad"})}
  end

  def handle_event("reset_empty", _params, socket) do
    {:noreply,
     socket
     |> assign(:apron_count, 0)
     |> stream(:aprons, [], reset: true)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 13 · Alert capstone stream
      </p>

      <h1>Alert capstone stream</h1>
      <p class="lede">
        Clerk {@clerk} inserts, deletes, and resets {@craft} aprons at Alert.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p id="apron-count">{@apron_count}</p>

      <button id="add-lincoln" type="button" phx-click="add_lincoln">
        Add Lincoln Sea
      </button>
      <button id="clear-alert" type="button" phx-click="clear_alert">
        Clear Alert pad
      </button>
      <button id="reset-empty" type="button" phx-click="reset_empty">
        Reset empty
      </button>

      <div id="aprons" phx-update="stream">
        <p class="hidden only:block" id="empty-apron">No aprons open.</p>
        <p :for={{id, apron} <- @streams.aprons} id={id}>{apron.name}</p>
      </div>
    </Layouts.app>
    """
  end

  defp reset_board(socket) do
    socket
    |> assign(:apron_count, 1)
    |> stream(:aprons, [%{id: "alert", name: "Alert pad"}])
  end
end
