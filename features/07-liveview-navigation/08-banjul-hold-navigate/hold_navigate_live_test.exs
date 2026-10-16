defmodule PhoenixMultivitaminWeb.BanjulHoldNavigateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @desk "/features/07-liveview-navigation/08-banjul-hold-navigate"
  @stack @desk <> "/stack"

  test "an event push_navigate mounts the stack and drops desk ticks", %{conn: conn} do
    {:ok, view, _html} = live(conn, @desk)
    assert has_element?(view, "#clerk-name", "Fatou")
    view |> element("#tick-desk") |> render_click()
    assert has_element?(view, "#desk-ticks", "1")

    {:ok, stack, _html} =
      view
      |> element("#open-stack")
      |> render_click()
      |> follow_redirect(conn, @stack)

    assert has_element?(stack, "#surface-name", "stack")
    assert has_element?(stack, "#stack-ticks", "0")
    assert has_element?(stack, "#craft-name", "CRJ200")
  end
end
