defmodule PhoenixMultivitaminWeb.BumthangNestCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/09-bumthang-nest-card"

  test "the inner valley cell sits inside the outer card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#outer-clerk", "Dechen")
    assert has_element?(view, "#inner-valley", "Chhume")
  end
end
