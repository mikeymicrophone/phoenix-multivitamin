defmodule PhoenixMultivitaminWeb.EntebbeCargoManifestHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def new(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 07 · Entebbe cargo manifest
      </p>

      <h1>Entebbe cargo manifest</h1>
      <p class="lede">
        Clerk Kato files the Il-76. Submit stamps the Brussels pallet and redirects
        to the show path.
      </p>

      <form
        id="manifest-form"
        method="post"
        action={~p"/features/03-controllers-and-json/07-entebbe-cargo-manifest/manifests"}
      >
        <input type="hidden" name="_csrf_token" value={get_csrf_token()} />
        <input type="hidden" name="manifest[id]" value="brussels-il76" />
        <button id="file-manifest" type="submit">File the Brussels pallet</button>
      </form>
    </Layouts.catalog>
    """
  end

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 07 · Entebbe cargo manifest
      </p>

      <h1>Entebbe cargo manifest</h1>
      <p class="lede">
        Clerk {@manifest.clerk} filed the {@manifest.craft} toward {@manifest.destination}.
      </p>

      <dl class="station-meta">
        <dt>Destination</dt>
        <dd id="manifest-destination">{@manifest.destination}</dd>
        <dt>Cargo</dt>
        <dd id="manifest-cargo">{@manifest.cargo}</dd>
        <dt>Kilograms</dt>
        <dd id="manifest-kg">{@manifest.kg}</dd>
        <dt>Clerk</dt>
        <dd id="manifest-clerk">{@manifest.clerk}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/03-controllers-and-json/07-entebbe-cargo-manifest"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
