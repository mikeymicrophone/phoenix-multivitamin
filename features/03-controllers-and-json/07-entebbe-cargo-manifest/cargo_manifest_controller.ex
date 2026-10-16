# Controllers and JSON · 07 · Entebbe cargo manifest
#
# Teaches:
# - create/2 redirects to show after a successful write
# - The create action does not render a created template
# - redirected_to/1 in tests is the verified show path

defmodule PhoenixMultivitaminWeb.EntebbeCargoManifestController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @manifests %{
    "brussels-il76" => %{
      id: "brussels-il76",
      clerk: "Kato",
      craft: "Ilyushin Il-76",
      destination: "Brussels",
      cargo: "relief pallets",
      kg: 18_400
    }
  }

  def new(conn, _params) do
    conn
    |> assign(:page_title, "Entebbe cargo manifest")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> render(:new)
  end

  def create(conn, %{"manifest" => %{"id" => id}}) do
    redirect(conn,
      to: ~p"/features/03-controllers-and-json/07-entebbe-cargo-manifest/manifests/#{id}"
    )
  end

  def show(conn, %{"id" => id}) do
    manifest = Map.fetch!(@manifests, id)

    conn
    |> assign(:page_title, "Entebbe cargo manifest")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:manifest, manifest)
    |> render(:show)
  end
end
