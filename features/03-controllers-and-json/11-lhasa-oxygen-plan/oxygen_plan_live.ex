# Controllers and JSON · 11 · Lhasa oxygen plan
#
# Teaches:
# - Plug.Conn.send_resp/3 writes a short text ticket

defmodule PhoenixMultivitaminWeb.LhasaOxygenPlanLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Lhasa oxygen plan")
     |> assign(:station, "Lhasa Gonggar")
     |> assign(:person, "Dawa")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 11 · Lhasa oxygen plan
      </p>

      <h1>Lhasa oxygen plan</h1>
      <p class="lede">
        Planner {@person} prints a Comac C919 oxygen ticket at {@station}. <code>send_resp/3</code>
        writes plain text. No view module runs.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-ticket"
          href={~p"/features/03-controllers-and-json/11-lhasa-oxygen-plan/ticket"}
        >
          Print the oxygen ticket
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
