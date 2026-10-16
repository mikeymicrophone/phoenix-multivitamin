defmodule PhoenixMultivitaminWeb.DiliControllerSlipLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/09-forms-and-changesets/08-dili-controller-slip"
  @new @map <> "/slips/new"
  @create @map <> "/slips"
  @show @map <> "/slips/Baucau"

  test "the catalog page opens the controller form", %{conn: conn} do
    {:ok, view, _html} = live(conn, @map)
    assert has_element?(view, "#clerk-name", "Rosa")
    assert has_element?(view, "#open-slip-form")
  end

  test "the controller form posts a valid slip and redirects", %{conn: conn} do
    conn = get(conn, @new)
    html = html_response(conn, 200)
    assert html =~ "Dili controller slip"
    [_, token] = Regex.run(~r/csrf-token" content="([^"]+)"/, html)

    conn =
      conn
      |> recycle()
      |> post(@create, %{
        "_csrf_token" => token,
        "cn_slip" => %{
          "clerk" => "Rosa",
          "craft" => "IPTN CN-235",
          "destination" => "Baucau"
        }
      })

    assert redirected_to(conn) == @show
    conn = get(recycle(conn), redirected_to(conn))
    assert html_response(conn, 200) =~ "Baucau"
  end

  test "an invalid controller post re-renders the form", %{conn: conn} do
    conn = get(conn, @new)
    html = html_response(conn, 200)
    [_, token] = Regex.run(~r/csrf-token" content="([^"]+)"/, html)

    conn =
      conn
      |> recycle()
      |> post(@create, %{
        "_csrf_token" => token,
        "cn_slip" => %{"clerk" => "Rosa", "craft" => "IPTN CN-235", "destination" => "X"}
      })

    html = html_response(conn, 200)
    assert html =~ "should be at least 3 character"
  end
end
