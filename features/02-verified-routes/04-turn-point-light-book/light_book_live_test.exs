defmodule PhoenixMultivitaminWeb.TurnPointLightBookLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.TurnPointLightBookLive

  @path "/features/02-verified-routes/04-turn-point-light-book"

  test "static ~p paths use the statics prefix and match static_path/2 without a digest" do
    assert TurnPointLightBookLive.characteristic_plate_path() == "/images/logo.svg"
    assert TurnPointLightBookLive.book_path() == @path
    assert ~p"/favicon.ico" == "/favicon.ico"
    assert ~p"/robots.txt" == "/robots.txt"

    assert static_path(PhoenixMultivitaminWeb.Endpoint, "/images/logo.svg") ==
             "/images/logo.svg"

    assert static_integrity(PhoenixMultivitaminWeb.Endpoint, "/images/logo.svg") == nil
  end

  test "a missing file under a static prefix does not warn as a missing route" do
    id = System.unique_integer([:positive])
    mod = Module.concat(PhoenixMultivitaminWeb, "TurnPointMissingPlate#{id}")

    {_, diagnostics} =
      Code.with_diagnostics(fn ->
        Code.compile_string("""
        defmodule #{inspect(mod)} do
          use PhoenixMultivitaminWeb, :verified_routes

          def missing_plate_path do
            ~p"/images/missing-characteristic.svg"
          end
        end
        """)
      end)

    refute Enum.any?(diagnostics, fn diagnostic ->
             diagnostic_message(diagnostic) =~ "no route path"
           end)

    assert mod.missing_plate_path() == "/images/missing-characteristic.svg"
  end

  test "the light book renders the characteristic plate from ~p", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Turn Point Light"
    assert html =~ "Selene"
    assert has_element?(view, "#plate-path", "/images/logo.svg")
    assert has_element?(view, "#plate-static-path", "/images/logo.svg")
    assert has_element?(view, "#favicon-path", "/favicon.ico")
    assert has_element?(view, "#robots-path", "/robots.txt")
    assert has_element?(view, "#characteristic-plate[src='/images/logo.svg']")
    assert has_element?(view, "#plate-integrity", "nil")
  end

  defp diagnostic_message(%{message: message}) when is_binary(message), do: message
  defp diagnostic_message(other), do: inspect(other)
end
