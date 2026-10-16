defmodule PhoenixMultivitaminWeb.HarbinIceCityUploadLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/06-harbin-ice-city-upload"

  test "the MIME list accepts PNGs and groups their receipt", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#photos-form input[accept][multiple]")
    photos = file_input(view, "#photos-form", :photos, [wing_photo("left-wing.png"), wing_photo("right-wing.png")])
    render_upload(photos, "left-wing.png")
    render_upload(photos, "right-wing.png")
    view |> form("#photos-form") |> render_submit()
    assert has_element?(view, "#photo-receipt", ".png: 2")
  end

  test "a text attachment has an entry error and can be withdrawn", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    refused = file_input(view, "#photos-form", :photos, [flight_file("deice-notes.txt", "Harbin wing inspection")])
    assert {:error, _errors} = render_upload(refused, "deice-notes.txt")
    assert has_element?(view, "#photos-queue article [role=alert]", "not accepted")
    view |> form("#photos-form") |> render_submit()
    assert has_element?(view, "#photo-receipt", "No photographs filed")
    view |> element("#photos-queue article button") |> render_click()
    refute has_element?(view, "#photos-queue article")
  end
end
