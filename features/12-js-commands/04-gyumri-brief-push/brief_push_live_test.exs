defmodule PhoenixMultivitaminWeb.GyumriBriefPushLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/04-gyumri-brief-push"

  test "JS.push logs the brief on the server", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "show"
    assert html =~ "log_brief"
    assert has_element?(view, "#logged-brief", "quiet")

    view |> element("#open-brief") |> render_click()
    assert has_element?(view, "#logged-brief", "Shirak wave")
  end
end
