# Function components and HEEx · 03 · Filton Concorde labels
#
# Teaches:
# - embed_templates/1 turns .html.heex files into function components
# - Bodyless function heads declare attr/3 for those templates
# - Each embedded function is invoked like any other component

defmodule PhoenixMultivitaminWeb.FiltonConcordeLabelsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  embed_templates "*.html"

  attr :plate_run, :string, required: true
  attr :hours, :integer, default: 12
  attr :stance, :atom, values: [:grounded, :taxi, :display], default: :grounded

  def g_boac(assigns)

  attr :plate_run, :string, required: true
  attr :hours, :integer, default: 8
  attr :caption, :string, default: "straight Sierra Delta"

  def f_btsd(assigns)

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Filton Concorde labels")
     |> assign(:hall, "Aerospace Bristol · Filton")
     |> assign(:curator, "Isolde")
     |> assign(:sheet, "g_boac")}
  end

  @impl true
  def handle_event("print_f_btsd", _params, socket) do
    {:noreply, assign(socket, :sheet, "f_btsd")}
  end

  def handle_event("print_g_boac", _params, socket) do
    {:noreply, assign(socket, :sheet, "g_boac")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 03 · Filton Concorde labels
      </p>

      <h1>Filton Concorde labels</h1>
      <p class="lede">
        {@curator} prints frame labels at {@hall}. G-BOAC and F-BTSD each
        live in their own <code>.html.heex</code>
        file. <code>embed_templates/1</code>
        compiles those files into function
        components on this LiveView.
      </p>

      <div class="watch-actions">
        <button id="print-g-boac" type="button" phx-click="print_g_boac">
          Print G-BOAC
        </button>
        <button id="print-f-btsd" type="button" phx-click="print_f_btsd">
          Print F-BTSD
        </button>
      </div>

      <.g_boac :if={@sheet == "g_boac"} plate_run="CV-24-19" />
      <.f_btsd :if={@sheet == "f_btsd"} plate_run="CV-24-22" caption="with British markings" />
    </Layouts.catalog>
    """
  end
end
