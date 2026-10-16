# Core components and layouts · 05 · Oaxaca bare plate
#
# Teaches:
# - A page can render without Layouts.app (and without Layouts.catalog)
# - The root layout still supplies the HTML document

defmodule PhoenixMultivitaminWeb.OaxacaBarePlateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Oaxaca bare plate")
     |> assign(:printer, "Itzel")
     |> assign(:craft, "Cessna 182")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <main id="bare-plate">
      <h1>Oaxaca bare plate</h1>
      <p class="lede">
        Printer {@printer} stamps a {@craft} plate at Xoxocotlán with no app
        layout and no catalog shell. The root layout still wraps the document.
      </p>
      <p id="printer-name">{@printer}</p>
    </main>
    """
  end
end
