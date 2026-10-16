defmodule PhoenixMultivitaminWeb.SamarkandSilkUploadLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitamin.SamarkandArchive, as: Archive
  alias PhoenixMultivitaminWeb.SamarkandSilkUploadLive, as: SilkUploadLive

  @path "/features/14-uploads/10-samarkand-silk-upload"

  test "external inventory has its own queue and rejects empty submission", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#inventory-form input[type=file]")
    view |> form("#inventory-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Choose a file")
    assert has_element?(view, "#archive-receipt", "No inventory archived")
  end

  test "presigning supplies the registered uploader and a bounded signed PUT", %{conn: conn} do
    contents = "Samarkand cabin inventory"
    entry = %Phoenix.LiveView.UploadEntry{client_name: "silk.txt", client_size: byte_size(contents)}
    socket = %Phoenix.LiveView.Socket{}
    assert {:ok, metadata, ^socket} = SilkUploadLive.presign_inventory(entry, socket)
    assert metadata.uploader == "FlightArchive"
    assert {:ok, %{key: key, bytes: bytes}} = metadata.url |> Path.basename() |> Archive.verify()
    assert key == metadata.key
    assert bytes == byte_size(contents)
    on_exit(fn -> File.rm(Archive.path(key)) end)

    archived = conn |> put_req_header("content-type", "application/octet-stream") |> put(metadata.url, contents)
    assert response(archived, 201) == "Inventory archived"
    assert File.read!(Archive.path(key)) == contents

    replayed = build_conn() |> put_req_header("content-type", "application/octet-stream") |> put(metadata.url, contents)
    assert response(replayed, 409) == "Inventory already archived"
  end

  test "tampered capabilities and mismatched byte counts cannot write objects", %{conn: conn} do
    denied = conn |> put_req_header("content-type", "application/octet-stream") |> put(@path <> "/archive/retired-link", "inventory")
    assert response(denied, 403) =~ "invalid"

    key = Base.url_encode64(:crypto.strong_rand_bytes(18), padding: false)
    token = Archive.sign(key, 12)
    on_exit(fn -> File.rm(Archive.path(key)) end)
    mismatch = build_conn() |> put_req_header("content-type", "application/octet-stream") |> put(@path <> "/archive/" <> token, "short")
    assert response(mismatch, 422) =~ "signed size"
    refute File.exists?(Archive.path(key))
  end
end
