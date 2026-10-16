defmodule PhoenixMultivitaminWeb.AndoyaRocketEventsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/11-andoya-rocket-events"

  test "the connected mount pushes arm_stack only with connected: true", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Andøya Space"
    assert has_element?(view, "#tech-name", "Eirik")
    assert html =~ "Socket connected. The stack is armed with a push_event."

    assert_push_event view, "arm_stack", %{connected: true, apparatus: "ALV stack"}
    refute_push_event view, "arm_stack", %{connected: false, apparatus: "ALV stack"}
  end

  test "firing the stack pushes sound_stack and posts the log", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert_push_event view, "arm_stack", %{connected: true, apparatus: "ALV stack"}

    view |> element("#two-blasts") |> render_click()

    assert_push_event view, "sound_stack", %{blasts: 2, tone: "low motor"}
    assert has_element?(view, "#stack-log", "Stack fired, 2 pulses")
  end

  test "stack_status replies to a hook with the apparatus map", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert_push_event view, "arm_stack", %{connected: true, apparatus: "ALV stack"}

    render_hook(view, "stack_status", %{})

    assert_reply view, %{
      apparatus: "ALV stack",
      tech: "Eirik",
      ready?: true
    }

    assert has_element?(view, "#stack-log", "Status asked from the stack console")
  end
end
