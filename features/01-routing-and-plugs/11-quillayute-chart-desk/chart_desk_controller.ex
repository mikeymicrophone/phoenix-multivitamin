# Routing and plugs · 11 · Quillayute chart desk
#
# Teaches:
# - A plug that reads the session can redirect before the action
# - redirect/2 sends the response immediately; without halt/1 the action still runs
# - halt/1 after redirect is what keeps the charts in the drawer

defmodule PhoenixMultivitaminWeb.QuillayuteChartDeskController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  plug :require_officer when action == :desk
  plug :leaky_officer when action == :leaky_desk

  def roster(conn, _params) do
    conn
    |> assign(:page_title, "Quillayute chart desk")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:station, "Quillayute River Coast Guard Station")
    |> render(:roster)
  end

  def desk(conn, _params) do
    render_desk(conn)
  end

  def leaky_desk(conn, _params) do
    render_desk(conn)
  end

  defp render_desk(conn) do
    conn
    |> assign(:page_title, "Quillayute chart desk")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:station, "Quillayute River Coast Guard Station")
    |> assign(:officer, conn.assigns[:officer] || "the drawer latch")
    |> assign(:chart, "La Push bar approaches")
    |> assign(:charts_opened, true)
    |> render(:desk)
  end

  defp require_officer(conn, _opts) do
    case get_session(conn, :chart_officer) do
      name when is_binary(name) ->
        assign(conn, :officer, name)

      _ ->
        conn
        |> put_flash(:error, "Sign the roster before you open the chart desk.")
        |> redirect(to: ~p"/features/01-routing-and-plugs/11-quillayute-chart-desk/roster")
        |> halt()
    end
  end

  defp leaky_officer(conn, _opts) do
    case get_session(conn, :chart_officer) do
      name when is_binary(name) ->
        assign(conn, :officer, name)

      _ ->
        conn
        |> put_flash(:error, "Sign the roster before you open the chart desk.")
        |> redirect(to: ~p"/features/01-routing-and-plugs/11-quillayute-chart-desk/roster")
    end
  end
end
