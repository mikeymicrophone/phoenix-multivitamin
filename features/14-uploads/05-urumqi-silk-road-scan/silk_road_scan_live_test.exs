defmodule PhoenixMultivitaminWeb.UrumqiSilkRoadScanLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/05-urumqi-silk-road-scan"

  test "three releases exceed the configuration limit until one is withdrawn", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    releases = file_input(view, "#releases-form", :releases, [
      flight_file("kashgar.txt", "URC-KHG"), flight_file("hotan.txt", "URC-HTN"),
      flight_file("altay.txt", "URC-AAT")
    ])
    assert {:error, _errors} = render_upload(releases, "kashgar.txt")
    assert has_element?(view, "#releases-queue [role=alert]", "Too many files")
    view |> form("#releases-form") |> render_submit()
    assert has_element?(view, "#dispatch-receipt", "No releases filed")
    view |> element("#releases-queue article:last-of-type button") |> render_click()
    refute has_element?(view, "#releases-queue [role=alert]", "Too many files")
  end

  test "two completed releases form a sorted packet", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    releases = file_input(view, "#releases-form", :releases, [
      flight_file("kashgar.txt", "URC-KHG"), flight_file("hotan.txt", "URC-HTN")
    ])
    render_upload(releases, "kashgar.txt")
    render_upload(releases, "hotan.txt")
    view |> form("#releases-form") |> render_submit()
    assert has_element?(view, "#dispatch-receipt", "hotan.txt + kashgar.txt")
    refute has_element?(view, "#releases-queue article")
  end
end
