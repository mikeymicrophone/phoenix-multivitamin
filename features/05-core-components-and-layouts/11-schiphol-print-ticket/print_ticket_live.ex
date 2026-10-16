# Core components and layouts · 11 · Schiphol print ticket
#
# Teaches:
# - Nested layouts: catalog chrome around a local print jacket
# - live_action :print keeps the inner jacket without the catalog nav actions

defmodule PhoenixMultivitaminWeb.SchipholPrintTicketLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Schiphol print ticket")
     |> assign(:marshal, "Saskia")
     |> assign(:craft, "Embraer E190")}
  end

  @impl true
  def render(%{live_action: :print} = assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <.print_jacket marshal={@marshal} craft={@craft} />
    </Layouts.catalog>
    """
  end

  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Core components and layouts · 11 · Schiphol print ticket
      </p>

      <h1>Schiphol print ticket</h1>
      <p class="lede">
        Marshal {@marshal} prints a pushback ticket for an {@craft}. The print
        path nests a local jacket inside the catalog layout.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-print"
          href={~p"/features/05-core-components-and-layouts/11-schiphol-print-ticket/print"}
        >
          Open the print jacket
        </.link>
      </div>
    </Layouts.catalog>
    """
  end

  defp print_jacket(assigns) do
    ~H"""
    <article id="print-jacket" class="scenario">
      <p id="print-banner">print jacket</p>
      <h1>Schiphol print ticket</h1>
      <p class="lede">
        Marshal {@marshal} clears the {@craft} off pier E. This jacket is nested
        inside the catalog layout.
      </p>
      <p id="marshal-name">{@marshal}</p>
    </article>
    """
  end
end
