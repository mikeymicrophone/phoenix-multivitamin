defmodule PhoenixMultivitaminWeb.ChengduPandaChartUploadLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/04-chengdu-panda-chart-upload"

  test "withdrawing an unfinished chart leaves its sibling available", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    charts = file_input(view, "#charts-form", :charts, [
      flight_file("chengdu.pdf", "%PDF-chengdu", "application/pdf"),
      flight_file("jiuzhai.pdf", "%PDF-jiuzhai", "application/pdf")
    ])
    render_upload(charts, "chengdu.pdf", 50)
    view |> element("#charts-queue article:first-of-type button") |> render_click()
    refute has_element?(view, "#charts-queue article", "chengdu.pdf")
    assert has_element?(view, "#charts-queue article", "jiuzhai.pdf")
    render_upload(charts, "jiuzhai.pdf")
    view |> form("#charts-form") |> render_submit()
    assert has_element?(view, "#chart-count", "1 charts filed")
    refute has_element?(view, "#charts-queue article")
  end

  test "a stale or missing chart reference is rejected", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "withdraw_chart", %{"ref" => "retired-chart"})
    assert has_element?(view, "#flash-error", "no longer queued")
    render_hook(view, "withdraw_chart", %{})
    assert has_element?(view, "#flash-error", "Choose a queued chart")
    view |> form("#charts-form") |> render_submit()
    assert has_element?(view, "#chart-count", "0 charts filed")
  end
end
