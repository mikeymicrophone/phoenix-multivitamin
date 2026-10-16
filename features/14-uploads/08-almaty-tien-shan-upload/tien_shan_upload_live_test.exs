defmodule PhoenixMultivitaminWeb.AlmatyTienShanUploadLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/08-almaty-tien-shan-upload"

  test "automatic completion consumes one track while another remains queued", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#track-drop[phx-drop-target]")
    assert has_element?(view, "#tracks-form input[data-phx-auto-upload]")
    refute has_element?(view, "#tracks-form button[type=submit]")
    # Twenty bytes split evenly into two 50% chunks without byte rounding.
    contents = "Talgar rescue track\n"
    tracks = file_input(view, "#tracks-form", :tracks, [
      flight_file("talgar.txt", contents), flight_file("issyk.txt", "Issyk search track")
    ])
    render_upload(tracks, "talgar.txt", 50)
    assert has_element?(view, "#tracks-queue progress[value='50']")
    assert has_element?(view, "#track-count", "0 tracks received")
    # render_upload/3 sends an additional percentage, not a target percentage.
    render_upload(tracks, "talgar.txt", 50)
    assert has_element?(view, "#track-count", "1 tracks received")
    assert has_element?(view, "#track-receipts li", "talgar.txt")
    digest = :crypto.hash(:sha256, contents) |> Base.encode16(case: :lower)
    assert has_element?(view, "#track-receipts code", digest)
    refute has_element?(view, "#tracks-queue article", "talgar.txt")
    assert has_element?(view, "#tracks-queue article", "issyk.txt")
    render_upload(tracks, "issyk.txt")
    assert has_element?(view, "#track-count", "2 tracks received")
  end
end
