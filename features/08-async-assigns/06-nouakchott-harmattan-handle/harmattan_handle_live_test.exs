defmodule PhoenixMultivitaminWeb.NouakchottHarmattanHandleLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/06-nouakchott-harmattan-handle"

  test "handle_async fills visibility through AsyncResult.ok/2", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Mariem")
    html = render_async(view)
    assert html =~ "800 metres in dust"
    assert has_element?(view, "#visibility-value", "800 metres in dust")
    refute has_element?(view, "#visibility-loading")
    assert has_element?(view, "#craft-name", "Boeing 737-500")
  end
end
