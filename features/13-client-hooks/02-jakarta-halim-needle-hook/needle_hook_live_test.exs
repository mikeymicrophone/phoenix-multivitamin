defmodule PhoenixMultivitaminWeb.JakartaHalimNeedleHookLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/02-jakarta-halim-needle-hook"

  test "a server patch changes the ignored instrument's dataset", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#halim-needle[phx-hook$='.HeadingNeedle'][phx-update='ignore'][data-bearing='60'] canvas")
    view |> element("#face-apron") |> render_click()
    assert has_element?(view, "#halim-needle[data-bearing='120']")
    assert has_element?(view, "#bearing-readout", "120°")
  end

  test "invalid bearings leave the last heading intact", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    for bearing <- ["360", "-1", "90east", ""] do
      render_hook(view, "turn_needle", %{"bearing" => bearing})
      assert has_element?(view, "#bearing-readout", "60°")
      assert has_element?(view, "#bearing-status", "0 to 359")
    end

    render_hook(view, "turn_needle", %{})
    assert has_element?(view, "#bearing-status", "text")
  end
end
