# Async assigns · 06 · Nouakchott harmattan handle
#
# Teaches:
# - handle_async/3 receives {:ok, result}
# - AsyncResult.ok/2 is how the assign is filled by hand

defmodule PhoenixMultivitaminWeb.NouakchottHarmattanHandleLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias Phoenix.LiveView.AsyncResult

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Nouakchott harmattan handle", "Mariem", "Boeing 737-500")
     |> assign(:visibility, AsyncResult.loading())
     |> start_async(:harmattan, fn -> "800 metres in dust" end)}
  end

  @impl true
  def handle_async(:harmattan, {:ok, metres}, socket) do
    {:noreply, assign(socket, :visibility, AsyncResult.ok(socket.assigns.visibility, metres))}
  end

  def handle_async(:harmattan, {:exit, reason}, socket) do
    {:noreply,
     assign(socket, :visibility, AsyncResult.failed(socket.assigns.visibility, {:exit, reason}))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 06 · Nouakchott harmattan handle
      </p>

      <h1>Nouakchott harmattan handle</h1>
      <p class="lede">
        Clerk {@clerk} starts a harmattan task for the {@craft}. <code>handle_async/3</code>
        receives the metres.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p :if={@visibility.loading} id="visibility-loading">Harmattan still blowing.</p>
      <p :if={@visibility.ok?} id="visibility-value">{@visibility.result}</p>
    </Layouts.app>
    """
  end
end
