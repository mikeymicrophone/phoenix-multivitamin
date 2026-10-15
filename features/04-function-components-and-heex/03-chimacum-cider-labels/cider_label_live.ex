# Function components and HEEx · 03 · Chimacum cider labels
#
# Teaches:
# - embed_templates/1 turns .html.heex files into function components
# - Bodyless function heads declare attr/3 for those templates
# - Each embedded function is invoked like any other component

defmodule PhoenixMultivitaminWeb.ChimacumCiderLabelsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  embed_templates "*.html"

  attr :press_run, :string, required: true
  attr :bushels, :integer, default: 12
  attr :sweetness, :atom, values: [:dry, :off_dry, :sparkling], default: :dry

  def kingston_black(assigns)

  attr :press_run, :string, required: true
  attr :bushels, :integer, default: 8
  attr :blend, :string, default: "straight Yarlington"

  def yarlington_mill(assigns)

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Chimacum cider labels")
     |> assign(:mill, "Finnriver Cidery · Chimacum")
     |> assign(:cellarer, "Soren")
     |> assign(:sheet, "kingston")}
  end

  @impl true
  def handle_event("print_yarlington", _params, socket) do
    {:noreply, assign(socket, :sheet, "yarlington")}
  end

  def handle_event("print_kingston", _params, socket) do
    {:noreply, assign(socket, :sheet, "kingston")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 03 · Chimacum cider labels
      </p>

      <h1>Chimacum cider labels</h1>
      <p class="lede">
        {@cellarer} prints bottle labels at {@mill}. Kingston Black and
        Yarlington Mill each live in their own <code>.html.heex</code>
        file. <code>embed_templates/1</code>
        compiles those files into function
        components on this LiveView.
      </p>

      <div class="watch-actions">
        <button id="print-kingston" type="button" phx-click="print_kingston">
          Print Kingston Black
        </button>
        <button id="print-yarlington" type="button" phx-click="print_yarlington">
          Print Yarlington Mill
        </button>
      </div>

      <.kingston_black :if={@sheet == "kingston"} press_run="CV-24-19" />
      <.yarlington_mill :if={@sheet == "yarlington"} press_run="CV-24-22" blend="with Dabinett" />
    </Layouts.catalog>
    """
  end
end
