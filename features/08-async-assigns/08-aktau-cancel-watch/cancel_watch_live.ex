# Async assigns · 08 · Aktau cancel watch
#
# Teaches:
# - cancel_async/3 kills the in-flight METAR when the watch changes
# - The cancelled result is {:exit, {:shutdown, :cancel}}

defmodule PhoenixMultivitaminWeb.AktauCancelWatchLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Aktau cancel watch", "Aigerim", "Antonov An-24")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    watch = Map.get(params, "watch", "evening")

    socket =
      socket
      |> assign(:watch, watch)
      |> maybe_cancel_metar()
      |> fetch_metar(watch)

    {:noreply, socket}
  end

  @impl true
  def handle_event("patch_midwatch", _params, socket) do
    {:noreply,
     push_patch(socket,
       to: ~p"/features/08-async-assigns/08-aktau-cancel-watch?#{[watch: "midwatch"]}"
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 08 · Aktau cancel watch
      </p>

      <h1>Aktau cancel watch</h1>
      <p class="lede">
        Clerk {@clerk} cancels the evening METAR on the {@craft} when the
        watch patches. Midwatch starts a new fetch.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p id="watch-name">{@watch}</p>
      <p :if={@metar.loading} id="metar-loading">METAR still out over the Caspian.</p>
      <p :if={@metar.failed} id="metar-failed">{inspect(@metar.failed)}</p>
      <p :if={@metar.ok?} id="metar-value">{@metar.result}</p>

      <button id="patch-midwatch" type="button" phx-click="patch_midwatch">Patch midwatch</button>
    </Layouts.app>
    """
  end

  defp maybe_cancel_metar(socket) do
    if socket.assigns[:metar] do
      cancel_async(socket, :metar)
    else
      socket
    end
  end

  defp fetch_metar(socket, watch) do
    assign_async(socket, :metar, fn ->
      if watch == "evening" do
        receive do
          :never -> {:ok, %{metar: "evening late"}}
        after
          5_000 -> {:ok, %{metar: "evening late"}}
        end
      else
        {:ok, %{metar: "midwatch 25012KT"}}
      end
    end)
  end
end
