defmodule PhoenixMultivitaminWeb.MarrowstoneHornEventsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/11-marrowstone-horn-events"

  test "the connected mount pushes arm_horn only with connected: true", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Marrowstone Point Light"
    assert has_element?(view, "#keeper-name", "Linus")
    assert html =~ "Socket connected. The diaphone is armed with a push_event."

    assert_push_event view, "arm_horn", %{connected: true, apparatus: "Type F diaphone"}
    refute_push_event view, "arm_horn", %{connected: false, apparatus: "Type F diaphone"}
  end

  test "sounding the diaphone pushes sound_horn and posts the log", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert_push_event view, "arm_horn", %{connected: true, apparatus: "Type F diaphone"}

    view |> element("#two-blasts") |> render_click()

    assert_push_event view, "sound_horn", %{blasts: 2, tone: "low diaphone"}
    assert has_element?(view, "#horn-log", "Diaphone sounded, 2 blasts")
  end

  test "horn_status replies to a hook with the apparatus map", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert_push_event view, "arm_horn", %{connected: true, apparatus: "Type F diaphone"}

    render_hook(view, "horn_status", %{})

    assert_reply view, %{
      apparatus: "Type F diaphone",
      keeper: "Linus",
      ready?: true
    }

    assert has_element?(view, "#horn-log", "Status asked from the horn console")
  end
end
