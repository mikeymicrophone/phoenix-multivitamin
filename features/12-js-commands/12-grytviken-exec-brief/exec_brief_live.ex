# JS commands · 12 · Grytviken exec brief
#
# Teaches:
# - JS.exec/1 runs a command the server rendered into an attribute

defmodule PhoenixMultivitaminWeb.GrytvikenExecBriefLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Grytviken exec brief")
     |> assign(:clerk, "Kirsten")
     |> assign(:craft, "Aerospatiale Alouette III")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · JS commands · 12 · Grytviken exec brief
      </p>

      <h1>Grytviken exec brief</h1>
      <p class="lede">
        Clerk {@clerk} execs a server-rendered show command on the {@craft} whale-bird brief.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <div id="brief-card" data-open-brief={JS.show(to: "#whale-brief")}>
        <button
          id="exec-brief"
          type="button"
          phx-click={JS.exec("data-open-brief", to: "#brief-card")}
        >
          Exec brief
        </button>
      </div>

      <p id="whale-brief" hidden>Whale-bird brief.</p>
    </Layouts.catalog>
    """
  end
end
