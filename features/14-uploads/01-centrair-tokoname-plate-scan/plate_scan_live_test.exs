defmodule PhoenixMultivitaminWeb.CentrairTokonamePlateScanLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/01-centrair-tokoname-plate-scan"

  test "a completed plate is consumed and its receipt survives", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Aiko")
    assert has_element?(view, "#plate-form input[type=file][accept]")
    plate = file_input(view, "#plate-form", :plate, [flight_file("JA892A.pdf", "%PDF-plate", "application/pdf")])
    render_upload(plate, "JA892A.pdf")
    assert has_element?(view, "#plate-queue article", "JA892A.pdf")
    view |> form("#plate-form") |> render_submit()
    assert has_element?(view, "#plate-receipt", "JA892A.pdf · 10 bytes")
    refute has_element?(view, "#plate-queue article")
  end

  test "empty and unfinished plates are not consumed", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    view |> form("#plate-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Choose a file")
    plate = file_input(view, "#plate-form", :plate, [flight_file("JA893A.pdf", "Centrair plate", "application/pdf")])
    render_upload(plate, "JA893A.pdf", 50)
    view |> form("#plate-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Wait for every transfer")
    assert has_element?(view, "#plate-queue progress[value='50']")
    assert has_element?(view, "#plate-receipt", "No plate filed")
  end
end
