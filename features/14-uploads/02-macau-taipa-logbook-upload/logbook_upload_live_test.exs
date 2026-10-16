defmodule PhoenixMultivitaminWeb.MacauTaipaLogbookUploadLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/02-macau-taipa-logbook-upload"

  test "captain input accompanies a text logbook", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#logbook-form input[name='logbook[captain]']")
    upload = file_input(view, "#logbook-form", :logbook, [flight_file("taipa.txt", "MFM-TPE\nTPE-MFM\n")])
    render_upload(upload, "taipa.txt")
    view |> form("#logbook-form", logbook: %{captain: "Inês"}) |> render_change()
    view |> form("#logbook-form", logbook: %{captain: "Inês"}) |> render_submit()
    assert has_element?(view, "#logbook-receipt", "Inês · 2 sectors")
    refute has_element?(view, "#logbook-queue article")
  end

  test "blank captain retains a completed logbook for correction", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    upload = file_input(view, "#logbook-form", :logbook, [flight_file("night.txt", "MFM-HAN\n")])
    render_upload(upload, "night.txt")
    view |> form("#logbook-form", logbook: %{captain: " "}) |> render_submit()
    assert has_element?(view, "#flash-error", "Name the captain")
    assert has_element?(view, "#logbook-queue article", "night.txt")
    render_hook(view, "file_logbook", %{})
    assert has_element?(view, "#logbook-queue article", "night.txt")
    view |> form("#logbook-form", logbook: %{captain: "Joana"}) |> render_submit()
    assert has_element?(view, "#logbook-receipt", "Joana · 1 sectors")
  end
end
