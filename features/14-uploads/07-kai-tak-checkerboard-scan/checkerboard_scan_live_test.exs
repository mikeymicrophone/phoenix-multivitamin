defmodule PhoenixMultivitaminWeb.KaiTakCheckerboardScanLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/07-kai-tak-checkerboard-scan"

  test "an oversized caption is replaced before consumption", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    refused = file_input(view, "#caption-form", :caption, [flight_file("long-caption.txt", String.duplicate("K", 129))])
    assert {:error, _errors} = render_upload(refused, "long-caption.txt")
    assert has_element?(view, "#caption-queue article [role=alert]", "byte limit")
    view |> form("#caption-form") |> render_submit()
    assert has_element?(view, "#flash-error", "at most 128 bytes")
    view |> element("#caption-queue article button") |> render_click()
    replacement = file_input(view, "#caption-form", :caption, [flight_file("checkerboard.txt", "Turn at the Checkerboard\n")])
    render_upload(replacement, "checkerboard.txt")
    view |> form("#caption-form") |> render_submit()
    assert has_element?(view, "#caption-receipt", "Turn at the Checkerboard")
    refute has_element?(view, "#caption-queue article")
  end

  test "empty and partial captions stay unfiled", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    view |> form("#caption-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Choose a file")
    caption = file_input(view, "#caption-form", :caption, [flight_file("turn.txt", "Approach runway 13")])
    render_upload(caption, "turn.txt", 50)
    view |> form("#caption-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Wait for every transfer")
    assert has_element?(view, "#caption-receipt", "No caption filed")
  end
end
