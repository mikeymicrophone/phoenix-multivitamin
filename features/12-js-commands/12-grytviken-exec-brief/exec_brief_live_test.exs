defmodule PhoenixMultivitaminWeb.GrytvikenExecBriefLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/12-grytviken-exec-brief"

  test "exec reads the server-rendered show command", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Kirsten")
    assert html =~ "exec"
    assert html =~ "data-open-brief"
    assert html =~ "show"
    assert html =~ "#whale-brief"
  end
end
