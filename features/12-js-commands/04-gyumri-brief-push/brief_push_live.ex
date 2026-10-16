# JS commands · 04 · Gyumri brief push
#
# Teaches:
# - JS.push value, target, and loading options combined with a client command
# - A guarded event head reads the stand from the pushed payload

defmodule PhoenixMultivitaminWeb.GyumriBriefPushLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Gyumri brief push", "Ani", "Ilyushin Il-62")
     |> assign(:logged, "quiet")}
  end

  @impl true
  def handle_event("log_brief", %{"stand" => stand}, socket)
      when is_binary(stand) and stand == "Shirak" do
    {:noreply, assign(socket, :logged, "Shirak wave")}
  end

  def handle_event("log_brief", _params, socket) do
    {:noreply, put_flash(socket, :error, "Choose the Shirak stand for this brief.")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 04 · Gyumri brief push
      </p>

      <h1>Gyumri brief push</h1>
      <p class="lede">
        Clerk {@clerk} opens the {@craft} brief on the client and pushes the
        log to the server.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <p id="logged-brief">{@logged}</p>

      <button
        id="open-brief"
        type="button"
        aria-controls="shirak-brief"
        phx-click={
          JS.remove_attribute("hidden", to: "#shirak-brief")
          |> JS.show(to: "#shirak-brief")
          |> JS.push("log_brief",
            value: %{stand: "Shirak"},
            target: "#logged-brief",
            loading: "#open-brief"
          )
        }
      >
        Open brief
      </button>

      <p id="shirak-brief" hidden>Shirak wave on the climb.</p>
    </Layouts.app>
    """
  end
end
