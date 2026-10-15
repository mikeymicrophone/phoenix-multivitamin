defmodule PhoenixMultivitaminWeb.PatosIslandFogLoggerLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.PatosIslandFogLoggerLive
  alias PhoenixMultivitaminWeb.PatosIslandWatch

  @path "/features/02-verified-routes/03-patos-island-fog-logger"

  test "a derived Phoenix.Param slug interpolates into the watch path" do
    dawn = %PatosIslandWatch{
      slug: "dawn",
      keeper: "Orrin",
      window: "04:00–08:00",
      horn: "two-blast"
    }

    dusk = %PatosIslandWatch{
      slug: "dusk",
      keeper: "Tamsin",
      window: "16:00–20:00",
      horn: "one-blast"
    }

    assert PatosIslandFogLoggerLive.watch_path(dawn) == "#{@path}/watches/dawn"
    assert PatosIslandFogLoggerLive.watch_path(dusk) == "#{@path}/watches/dusk"
    assert PatosIslandFogLoggerLive.watch_path("west bank") == "#{@path}/watches/west%20bank"
  end

  test "a map cannot be interpolated as a path segment" do
    assert_raise ArgumentError, ~r/maps cannot be converted to_param/, fn ->
      PatosIslandFogLoggerLive.watch_path(%{slug: "dawn"})
    end
  end

  test "a list of binaries becomes extra path segments at runtime" do
    assert PatosIslandFogLoggerLive.watch_path(["dawn", "dusk"]) ==
             "#{@path}/watches/dawn/dusk"
  end

  test "navigating to a watch struct path loads that keeper", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Patos Island Light"
    assert has_element?(view, "#keeper-name", "Orrin")
    assert has_element?(view, "#dawn-watch-path", "#{@path}/watches/dawn")
    assert has_element?(view, "#encoded-watch-path", "west%20bank")

    {:ok, dusk_view, _html} =
      view
      |> element("#dusk-watch-link")
      |> render_click()
      |> follow_redirect(conn, "#{@path}/watches/dusk")

    assert has_element?(dusk_view, "#keeper-name", "Tamsin")
    assert has_element?(dusk_view, "#watch-horn", "one-blast")
    assert has_element?(dusk_view, "#fog-copy", "Tamsin on dusk watch")
  end
end
