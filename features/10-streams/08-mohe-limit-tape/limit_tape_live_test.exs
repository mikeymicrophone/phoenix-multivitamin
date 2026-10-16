defmodule PhoenixMultivitaminWeb.MoheLimitTapeLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/08-mohe-limit-tape"

  test "a fourth line drops the last tape", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#tapes", "QNH 1011")

    view |> element("#prepend-aurora") |> render_click()
    assert has_element?(view, "#tapes", "Aurora over the Amur")
    refute has_element?(view, "#tapes", "QNH 1011")
  end

  test "appending with a negative limit drops the first tape", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#append-aurora") |> render_click()

    assert has_element?(view, "#tapes-aurora", "Aurora over the Amur")
    assert has_element?(view, "#tapes-two", "Rime on the vane")
    assert has_element?(view, "#tapes-three", "QNH 1011")
    refute has_element?(view, "#tapes-one")
  end
end
