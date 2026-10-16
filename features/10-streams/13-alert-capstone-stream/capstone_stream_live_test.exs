defmodule PhoenixMultivitaminWeb.AlertCapstoneStreamLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/13-alert-capstone-stream"

  test "insert, delete, and reset empty the Alert apron", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Neevee")
    assert has_element?(view, "#aprons", "Alert pad")

    view |> element("#add-lincoln") |> render_click()
    assert has_element?(view, "#aprons", "Lincoln Sea")
    assert has_element?(view, "#apron-count", "2")

    view |> element("#clear-alert") |> render_click()
    refute has_element?(view, "#aprons", "Alert pad")
    assert has_element?(view, "#aprons", "Lincoln Sea")

    view |> element("#reset-empty") |> render_click()
    refute has_element?(view, "#aprons", "Lincoln Sea")
    assert has_element?(view, "#empty-apron", "No aprons open.")
    assert has_element?(view, "#apron-count", "0")
  end
end
