defmodule PhoenixMultivitaminWeb.IlulissatIceLoggerLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.IlulissatIceLoggerLive
  alias PhoenixMultivitaminWeb.IlulissatIceWatch

  @path "/features/02-verified-routes/03-ilulissat-ice-logger"

  test "a derived Phoenix.Param slug interpolates into the watch path" do
    dawn = %IlulissatIceWatch{
      slug: "dawn",
      observer: "Nivi",
      window: "04:00–08:00",
      cell: "two-cell"
    }

    dusk = %IlulissatIceWatch{
      slug: "dusk",
      observer: "Malik",
      window: "16:00–20:00",
      cell: "one-cell"
    }

    assert IlulissatIceLoggerLive.watch_path(dawn) == "#{@path}/watches/dawn"
    assert IlulissatIceLoggerLive.watch_path(dusk) == "#{@path}/watches/dusk"
    assert IlulissatIceLoggerLive.watch_path("ice fjord") == "#{@path}/watches/ice%20fjord"
  end

  test "a map cannot be interpolated as a path segment" do
    assert_raise ArgumentError, ~r/maps cannot be converted to_param/, fn ->
      IlulissatIceLoggerLive.watch_path(%{slug: "dawn"})
    end
  end

  test "a list of binaries becomes extra path segments at runtime" do
    assert IlulissatIceLoggerLive.watch_path(["dawn", "dusk"]) ==
             "#{@path}/watches/dawn/dusk"
  end

  test "navigating to a watch struct path loads that observer", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Ilulissat ice logger"
    assert has_element?(view, "#observer-name", "Nivi")
    assert has_element?(view, "#dawn-watch-path", "#{@path}/watches/dawn")
    assert has_element?(view, "#encoded-watch-path", "ice%20fjord")

    {:ok, dusk_view, _html} =
      view
      |> element("#dusk-watch-link")
      |> render_click()
      |> follow_redirect(conn, "#{@path}/watches/dusk")

    assert has_element?(dusk_view, "#observer-name", "Malik")
    assert has_element?(dusk_view, "#watch-cell", "one-cell")
    assert has_element?(dusk_view, "#ice-copy", "Malik on dusk watch")
  end
end
