defmodule PhoenixMultivitaminWeb.AshgabatKarakumScanLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  alias PhoenixMultivitamin.AshgabatArchive, as: Archive

  @path "/features/14-uploads/13-ashgabat-karakum-scan"

  test "withdrawn plates are excluded and the remaining bytes are stored privately", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    plates = file_input(view, "#plates-form", :plates, [
      flight_file("karakum.pdf", "%PDF-desert-dispatch", "application/pdf"),
      flight_file("superseded.pdf", "%PDF-outdated", "application/pdf")
    ])
    render_upload(plates, "karakum.pdf")
    view |> element("#plates-queue article:last-of-type button") |> render_click()
    view |> form("#plates-form") |> render_submit()
    assert has_element?(view, "#stored-count", "1 plates stored")
    assert has_element?(view, "#storage-notice", "Packet stored")
    assert has_element?(view, "#stored-plates li", "karakum.pdf")
    refute has_element?(view, "#stored-plates li", "superseded.pdf")
    refute has_element?(view, "#plates-queue article")

    [destination] = view |> render() |> LazyHTML.from_fragment()
      |> LazyHTML.filter("#stored-plates li") |> LazyHTML.attribute("data-path")
    on_exit(fn -> File.rm_rf(Path.dirname(destination)) end)
    assert String.starts_with?(destination, Archive.root() <> "/")
    refute String.ends_with?(destination, "karakum.pdf")
    assert File.read!(destination) == "%PDF-desert-dispatch"
  end

  @tag :tmp_dir
  test "archive copy failures return an error without a receipt", %{tmp_dir: directory} do
    batch = "blocked-" <> Base.url_encode64(:crypto.strong_rand_bytes(12), padding: false)
    blocked = Path.join(Archive.root(), batch)
    File.mkdir_p!(Archive.root())
    File.write!(blocked, "archive volume offline")
    on_exit(fn -> File.rm(blocked) end)
    source = Path.join(directory, "release.pdf")
    File.write!(source, "%PDF-release")
    assert {:error, _reason} = Archive.store(batch, "dispatch-plate", source)
  end

  test "an empty dispatch packet is rejected", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    view |> form("#plates-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Choose a file")
    assert has_element?(view, "#stored-count", "0 plates stored")
  end
end
