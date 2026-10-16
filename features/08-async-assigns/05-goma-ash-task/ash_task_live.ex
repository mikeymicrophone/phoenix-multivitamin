# Async assigns · 05 · Goma ash task
#
# Teaches:
# - start_async/3 for a task that is not an assign_async key
# - handle_async/3 writes a plain assign

defmodule PhoenixMultivitaminWeb.GomaAshTaskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Goma ash task")
     |> assign(:clerk, "Amani")
     |> assign(:craft, "Mil Mi-8")
     |> assign(:ash_line, nil)
     |> start_async(:ash_task, fn -> "Nyiragongo ash to FL180" end)}
  end

  @impl true
  def handle_async(:ash_task, {:ok, line}, socket) do
    {:noreply, assign(socket, :ash_line, line)}
  end

  def handle_async(:ash_task, {:exit, _reason}, socket) do
    {:noreply, assign(socket, :ash_line, "ash task exited")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 05 · Goma ash task
      </p>

      <h1>Goma ash task</h1>
      <p class="lede">
        Clerk {@clerk} starts an ash task for the {@craft}. The result is a
        plain assign, not an AsyncResult key.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={is_nil(@ash_line)} id="ash-pending">Ash task still climbing.</p>
      <p :if={@ash_line} id="ash-line">{@ash_line}</p>
    </Layouts.catalog>
    """
  end
end
