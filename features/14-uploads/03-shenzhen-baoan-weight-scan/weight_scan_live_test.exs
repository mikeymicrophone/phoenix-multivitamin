defmodule PhoenixMultivitaminWeb.ShenzhenBaoanWeightScanLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixMultivitaminWeb.UploadFixtures

  @path "/features/14-uploads/03-shenzhen-baoan-weight-scan"

  test "CSV rows become a typed, streamed weight receipt", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    weights = "pallet,kg\nPMC7632,418\nAKE2094,92\nAKE2095,-7\nAKE2096,unknown\n"
    upload = file_input(view, "#weights-form", :weights, [flight_file("baoan.csv", weights, "text/csv")])
    render_upload(upload, "baoan.csv")
    view |> form("#weights-form") |> render_submit()
    assert has_element?(view, "#gross-weight", "510 kg")
    assert has_element?(view, "#weight-receipts li", "baoan.csv · 510 kg")
    refute has_element?(view, "#weights-queue article")

    second = file_input(view, "#weights-form", :weights, [flight_file("relief.csv", "PMC7733,20\n", "text/csv")])
    render_upload(second, "relief.csv")
    view |> form("#weights-form") |> render_submit()
    assert has_element?(view, "#gross-weight", "530 kg")
    assert has_element?(view, "#weight-receipts li", "baoan.csv")
    assert has_element?(view, "#weight-receipts li", "relief.csv")
  end

  test "an empty queue cannot create a receipt", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    view |> form("#weights-form") |> render_submit()
    assert has_element?(view, "#flash-error", "Choose a file")
    refute has_element?(view, "#weight-receipts li")
  end
end
