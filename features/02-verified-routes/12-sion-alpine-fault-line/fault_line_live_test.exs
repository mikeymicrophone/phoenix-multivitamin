defmodule PhoenixMultivitaminWeb.SionAlpineFaultLineLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import ExUnit.CaptureIO

  alias PhoenixMultivitaminWeb.SionAlpineFaultLineLive

  @path "/features/02-verified-routes/12-sion-alpine-fault-line"

  test "the current span still verifies" do
    assert SionAlpineFaultLineLive.current_span_path() == @path
  end

  test "a removed route warns at compile time with no route path" do
    {stderr, diagnostics, mod} =
      compile_probe("""
        def collapsed_ridge_path do
          ~p"/features/02-verified-routes/12-sion-alpine-fault-line/collapsed-ridge"
        end
      """)

    message = "#{stderr} #{inspect(diagnostics)}"
    assert message =~ "no route path"
    assert message =~ "PhoenixMultivitaminWeb.Router"
    assert message =~ "collapsed-ridge"

    assert mod.collapsed_ridge_path() == "#{@path}/collapsed-ridge"
  end

  test "a fully dynamic last segment still warns when the stand-in path misses" do
    {stderr, diagnostics, _mod} =
      compile_probe("""
        def dynamic_span_path(span) do
          ~p"/features/02-verified-routes/12-sion-alpine-fault-line/\#{span}"
        end
      """)

    message = "#{stderr} #{inspect(diagnostics)}"
    assert message =~ "no route path"
  end

  test "two adjacent dynamic segments skip the missing-route warning" do
    {stderr, diagnostics, mod} =
      compile_probe("""
        def unverifiable_span_path(feature, span) do
          ~p"/features/\#{feature}/\#{span}"
        end
      """)

    message = "#{stderr} #{inspect(diagnostics)}"
    refute message =~ "no route path"
    refute message =~ "collapsed-ridge"

    assert mod.unverifiable_span_path(
             "02-verified-routes",
             "12-sion-alpine-fault-line/collapsed-ridge"
           ) == "/features/02-verified-routes/12-sion-alpine-fault-line%2Fcollapsed-ridge"
  end

  test "the fault line board shows the current span and the captured warning copy", %{
    conn: conn
  } do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Sion alpine strip"
    assert html =~ "Remo"
    assert has_element?(view, "#span-path", @path)
    assert has_element?(view, "#warning-copy", "no route path")
    assert has_element?(view, "#warning-copy", "collapsed-ridge")
  end

  defp compile_probe(body) do
    id = System.unique_integer([:positive])
    mod = Module.concat(PhoenixMultivitaminWeb, "SionAlpineProbe#{id}")

    source = """
    defmodule #{inspect(mod)} do
      use PhoenixMultivitaminWeb, :verified_routes

    #{body}
    end
    """

    {{stderr, _compiled}, diagnostics} =
      Code.with_diagnostics(fn ->
        stderr = capture_io(:stderr, fn -> Code.compile_string(source) end)
        {stderr, :ok}
      end)

    {stderr, diagnostics, mod}
  end
end
