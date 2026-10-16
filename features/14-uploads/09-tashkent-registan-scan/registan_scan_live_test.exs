defmodule PhoenixMultivitaminWeb.TashkentRegistanScanLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/09-tashkent-registan-scan"

  test "progress is weighted by bytes and consumption waits for every brief", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    briefs = file_input(view, "#briefs-form", :briefs, [
      flight_file("registan.txt", String.duplicate("R", 100)),
      flight_file("bukhara.txt", String.duplicate("B", 300))
    ])
    render_upload(briefs, "registan.txt", 100)
    assert has_element?(view, "#brief-progress", "25% received")
    view |> form("#briefs-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Wait for every transfer")
    assert has_element?(view, "#filed-bytes", "0 bytes filed")
    render_upload(briefs, "bukhara.txt", 100)
    assert has_element?(view, "#brief-progress", "100% received")
    view |> form("#briefs-form") |> render_submit()
    assert has_element?(view, "#filed-bytes", "400 bytes filed")
    refute has_element?(view, "#briefs-queue article")
  end
end
