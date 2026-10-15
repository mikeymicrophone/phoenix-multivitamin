defmodule PhoenixMultivitaminWeb.BrownsPointFogDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.BrownsPointFogDeskLive

  @desk "/features/02-verified-routes/06-browns-point-fog-desk"
  @horn "/features/02-verified-routes/06-browns-point-fog-desk/horn-cabinet"

  test "push_patch keeps the process; push_navigate mounts the horn cabinet", %{conn: conn} do
    assert BrownsPointFogDeskLive.desk_path() == @desk
    assert BrownsPointFogDeskLive.horn_cabinet_path() == @horn

    {:ok, view, html} = live(conn, @desk)

    assert html =~ "Browns Point Light"
    assert has_element?(view, "#keeper-name", "Pax")
    assert has_element?(view, "#mount-count", "1")
    assert has_element?(view, "#surface-name", "desk")

    view |> element("#sound-horn") |> render_click()
    assert has_element?(view, "#horn-blasts", "1")

    view |> element("#patch-midwatch") |> render_click()
    assert_patch(view, "#{@desk}?watch=midwatch")
    assert has_element?(view, "#keeper-name", "Nola")
    assert has_element?(view, "#mount-count", "1")
    assert has_element?(view, "#horn-blasts", "1")

    {:ok, horn_view, _html} =
      view
      |> element("#navigate-horn")
      |> render_click()
      |> follow_redirect(conn, @horn)

    assert has_element?(horn_view, "#surface-name", "horn")
    assert has_element?(horn_view, "#surface-banner", "Horn cabinet")
    assert has_element?(horn_view, "#mount-count", "1")
    assert has_element?(horn_view, "#horn-blasts", "0")
  end

  test "a patch link on the desk does not remount", %{conn: conn} do
    {:ok, view, _html} = live(conn, @desk)

    view |> element("#sound-horn") |> render_click()
    view |> element("#midwatch-desk-link") |> render_click()

    assert_patch(view, "#{@desk}?watch=midwatch")
    assert has_element?(view, "#horn-blasts", "1")
    assert has_element?(view, "#desk-copy", "Nola on midwatch")
  end
end
