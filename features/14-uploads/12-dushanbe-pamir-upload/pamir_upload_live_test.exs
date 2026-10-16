defmodule PhoenixMultivitaminWeb.DushanbePamirUploadLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/12-dushanbe-pamir-upload"

  test "content failure stays beside the postponed entry until it is withdrawn", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    report = file_input(view, "#report-form", :report, [flight_file("khorog.txt", "KHOROG\nStrip clear")])
    render_upload(report, "khorog.txt")
    view |> form("#report-form") |> render_submit()
    assert has_element?(view, "#report-queue article [role=alert]", "first line must be PAMIR")
    assert has_element?(view, "#report-queue article", "khorog.txt")
    assert has_element?(view, "#report-receipt", "No strip report filed")
    view |> form("#report-form") |> render_submit()
    assert has_element?(view, "#report-queue article [role=alert]", "PAMIR")
    view |> element("#report-queue article button") |> render_click()
    refute has_element?(view, "#report-queue article")

    corrected = file_input(view, "#report-form", :report, [flight_file("pamir.txt", "PAMIR\nKhorog strip clear")])
    render_upload(corrected, "pamir.txt")
    view |> form("#report-form") |> render_submit()
    assert has_element?(view, "#report-receipt", "pamir.txt")
    refute has_element?(view, "#report-queue article")
  end
end
