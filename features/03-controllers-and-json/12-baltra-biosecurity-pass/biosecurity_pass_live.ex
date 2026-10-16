# Controllers and JSON · 12 · Baltra biosecurity pass
#
# Teaches:
# - Multiple clauses of the same action pick the pass kind

defmodule PhoenixMultivitaminWeb.BaltraBiosecurityPassLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Baltra biosecurity pass")
     |> assign(:station, "Seymour")
     |> assign(:person, "Paz")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 12 · Baltra biosecurity pass
      </p>

      <h1>Baltra biosecurity pass</h1>
      <p class="lede">
        Inspector {@person} stamps Avro RJ100 arrivals at {@station}. <code>show/2</code>
        has a clause per pass kind. An unknown kind hits the last clause.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-galapagos-pass"
          href={~p"/features/03-controllers-and-json/12-baltra-biosecurity-pass/passes/galapagos"}
        >
          Open a Galápagos pass
        </.link>
        <.link
          id="open-transit-pass"
          href={~p"/features/03-controllers-and-json/12-baltra-biosecurity-pass/passes/transit"}
        >
          Open a transit pass
        </.link>
        <.link
          id="open-unknown-pass"
          href={~p"/features/03-controllers-and-json/12-baltra-biosecurity-pass/passes/unknown"}
        >
          Open an unknown kind
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
