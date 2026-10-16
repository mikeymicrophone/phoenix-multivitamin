# JS commands · 04 · Gyumri brief push
#
# Teaches:
# - JS.push/1 combined with a client command

defmodule PhoenixMultivitaminWeb.GyumriBriefPushLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Gyumri brief push")
     |> assign(:clerk, "Ani")
     |> assign(:craft, "Ilyushin Il-62")
     |> assign(:logged, "quiet")}
  end

  @impl true
  def handle_event("log_brief", _params, socket) do
    {:noreply, assign(socket, :logged, "Shirak wave")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 04 · Gyumri brief push
      </p>

      <h1>Gyumri brief push</h1>
      <p class="lede">
        Clerk {@clerk} opens the {@craft} brief on the client and pushes the
        log to the server.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="logged-brief">{@logged}</p>

      <button
        id="open-brief"
        type="button"
        phx-click={JS.show(to: "#shirak-brief") |> JS.push("log_brief")}
      >
        Open brief
      </button>

      <p id="shirak-brief" hidden>Shirak wave on the climb.</p>
    </Layouts.catalog>
    """
  end
end
