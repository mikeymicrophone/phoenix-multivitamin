defmodule PhoenixMultivitaminWeb.CourchevelAltimeterDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.CourchevelAltimeterDeskLive

  @desk "/features/02-verified-routes/06-courchevel-altimeter-desk"
  @cabinet "/features/02-verified-routes/06-courchevel-altimeter-desk/altimeter-cabinet"

  test "push_patch keeps the process; push_navigate mounts the altimeter cabinet", %{conn: conn} do
    assert CourchevelAltimeterDeskLive.desk_path() == @desk
    assert CourchevelAltimeterDeskLive.altimeter_cabinet_path() == @cabinet

    {:ok, view, html} = live(conn, @desk)

    assert html =~ "Courchevel altimeter desk"
    assert has_element?(view, "#clerk-name", "Yves")
    assert has_element?(view, "#mount-count", "1")
    assert has_element?(view, "#surface-name", "desk")

    view |> element("#log-click") |> render_click()
    assert has_element?(view, "#cabinet-clicks", "1")

    view |> element("#patch-midwatch") |> render_click()
    assert_patch(view, "#{@desk}?watch=midwatch")
    assert has_element?(view, "#clerk-name", "Odile")
    assert has_element?(view, "#mount-count", "1")
    assert has_element?(view, "#cabinet-clicks", "1")

    {:ok, cabinet_view, _html} =
      view
      |> element("#navigate-cabinet")
      |> render_click()
      |> follow_redirect(conn, @cabinet)

    assert has_element?(cabinet_view, "#surface-name", "cabinet")
    assert has_element?(cabinet_view, "#surface-banner", "Altimeter cabinet")
    assert has_element?(cabinet_view, "#mount-count", "1")
    assert has_element?(cabinet_view, "#cabinet-clicks", "0")
  end

  test "a patch link on the desk does not remount", %{conn: conn} do
    {:ok, view, _html} = live(conn, @desk)

    view |> element("#log-click") |> render_click()
    view |> element("#midwatch-desk-link") |> render_click()

    assert_patch(view, "#{@desk}?watch=midwatch")
    assert has_element?(view, "#cabinet-clicks", "1")
    assert has_element?(view, "#desk-copy", "Odile on midwatch")
  end
end
