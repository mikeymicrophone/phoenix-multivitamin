# Controllers and JSON · 04 · Ulaanbaatar winter NOTAM
#
# Teaches:
# - The catalog page links a known NOTAM, a missing one, and a rescued explode

defmodule PhoenixMultivitaminWeb.UlaanbaatarWinterNotamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Ulaanbaatar winter NOTAM")
     |> assign(:station, "Chinggis Khaan")
     |> assign(:person, "Oyuna")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 04 · Ulaanbaatar winter NOTAM
      </p>

      <h1>Ulaanbaatar winter NOTAM</h1>
      <p class="lede">
        {@person} files winter ice NOTAMs at {@station} for a Fokker 100.
        A missing series is <code>action_fallback</code>. A bad runway letter is a
        rescued <code>ArgumentError</code> — the fallback never sees it.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-ice-notam"
          href={~p"/features/03-controllers-and-json/04-ulaanbaatar-winter-notam/notams/ubbn-ice"}
        >
          Open the ice NOTAM
        </.link>
        <.link
          id="open-missing-notam"
          href={~p"/features/03-controllers-and-json/04-ulaanbaatar-winter-notam/notams/missing"}
        >
          Ask for a missing series
        </.link>
        <.link
          id="open-explode"
          href={~p"/features/03-controllers-and-json/04-ulaanbaatar-winter-notam/explode"}
        >
          Explode a bad runway
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
