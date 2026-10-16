defmodule PhoenixMultivitaminWeb.BishkekAlaTooScanLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/11-bishkek-ala-too-scan"

  test "both image inputs preview and consume a landing pair", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    overview = file_input(view, "#landing-form", :overview, [wing_photo("ala-too.png")])
    render_upload(overview, "ala-too.png")
    assert has_element?(view, "#overview-queue img")
    view |> form("#landing-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Both landing views")
    assert has_element?(view, "#overview-queue article", "ala-too.png")

    detail = file_input(view, "#landing-form", :detail, [wing_photo("touchdown.png")])
    render_upload(detail, "touchdown.png")
    assert has_element?(view, "#detail-queue img")
    view |> form("#landing-form") |> render_submit()
    assert has_element?(view, "#pair-receipt", "ala-too.png / touchdown.png")
    refute has_element?(view, "#overview-queue article")
    refute has_element?(view, "#detail-queue article")
  end
end
