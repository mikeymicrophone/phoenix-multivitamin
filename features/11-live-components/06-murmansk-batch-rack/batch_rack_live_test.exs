defmodule PhoenixMultivitaminWeb.MurmanskBatchRackLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/06-murmansk-batch-rack"

  test "update_many/1 fills three QNH cells from one batch", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#qnh-kola", "1018")
    assert has_element?(view, "#qnh-teriberka", "1009")
    assert has_element?(view, "#qnh-lovozero", "1011")
    assert has_element?(view, "#batch-kola", "3")
    assert has_element?(view, "#batch-lovozero", "3")
  end
end
