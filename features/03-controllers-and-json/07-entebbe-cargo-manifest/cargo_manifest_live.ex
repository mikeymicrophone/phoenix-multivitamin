# Controllers and JSON · 07 · Entebbe cargo manifest
#
# Teaches:
# - A successful write redirects to the show path

defmodule PhoenixMultivitaminWeb.EntebbeCargoManifestLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Entebbe cargo manifest")
     |> assign(:station, "Entebbe")
     |> assign(:person, "Kato")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 07 · Entebbe cargo manifest
      </p>

      <h1>Entebbe cargo manifest</h1>
      <p class="lede">
        Clerk {@person} files an Il-76 manifest at {@station}. A successful write
        is a redirect to the show path, not a rendered create template.
      </p>

      <div class="watch-switcher">
        <.link
          id="open-new-manifest"
          href={~p"/features/03-controllers-and-json/07-entebbe-cargo-manifest/manifests/new"}
        >
          File a manifest
        </.link>
        <.link
          id="open-brussels-manifest"
          href={
            ~p"/features/03-controllers-and-json/07-entebbe-cargo-manifest/manifests/brussels-il76"
          }
        >
          Open the Brussels pallet
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
