# Routing and plugs · 07 · Colman Dock shed
#
# Teaches:
# - A controller plug that halt/1 skips later plugs and the action
# - Plugs that already ran stay on the conn; later ones never stamp
# - A valid ferry pass lets the whole stack, including show/2, finish

defmodule PhoenixMultivitaminWeb.ColmanDockShedController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  plug :stamp_dock
  plug :check_ferry_pass
  plug :stamp_turnstile

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Colman Dock shed")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:slip, "Seattle–Bainbridge")
    |> stamp_trace("show-action")
    |> render(:show)
  end

  defp stamp_dock(conn, _opts) do
    conn
    |> assign(:dock, "Colman Dock")
    |> assign(:agent, "Priya")
    |> stamp_trace("stamp-dock")
  end

  defp check_ferry_pass(conn, _opts) do
    conn = stamp_trace(conn, "check-pass")

    case get_req_header(conn, "x-ferry-pass") do
      ["wenatchee-walk-on"] ->
        assign(conn, :passenger, "walk-on for Wenatchee")

      _ ->
        conn
        |> assign(:page_title, "Colman Dock shed")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> put_status(:forbidden)
        |> render(:denied)
        |> halt()
    end
  end

  defp stamp_turnstile(conn, _opts) do
    conn
    |> assign(:turnstile, "open onto the overhead walk")
    |> stamp_trace("stamp-turnstile")
  end

  defp stamp_trace(conn, step) do
    assign(conn, :pipeline_trace, (conn.assigns[:pipeline_trace] || []) ++ [step])
  end
end
