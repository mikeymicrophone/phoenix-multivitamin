# Routing and plugs · 07 · Barra beach shed
#
# Teaches:
# - A controller plug that halt/1 skips later plugs and the action
# - Plugs that already ran stay on the conn; later ones never stamp
# - A valid beach pass lets the whole stack, including show/2, finish

defmodule PhoenixMultivitaminWeb.BarraBeachShedController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  plug :stamp_beach
  plug :check_beach_pass
  plug :stamp_turnstile

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Barra beach shed")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:slip, "Traigh Mhòr 07")
    |> stamp_trace("show-action")
    |> render(:show)
  end

  defp stamp_beach(conn, _opts) do
    conn
    |> assign(:beach, "Traigh Mhòr")
    |> assign(:marshal, "Eilidh")
    |> stamp_trace("stamp-beach")
  end

  defp check_beach_pass(conn, _opts) do
    conn = stamp_trace(conn, "check-pass")

    case get_req_header(conn, "x-beach-pass") do
      ["islander-beach"] ->
        assign(conn, :passenger, "walk-on for the Islander")

      _ ->
        conn
        |> assign(:page_title, "Barra beach shed")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> put_status(:forbidden)
        |> render(:denied)
        |> halt()
    end
  end

  defp stamp_turnstile(conn, _opts) do
    conn
    |> assign(:turnstile, "open onto the beach strip")
    |> stamp_trace("stamp-turnstile")
  end

  defp stamp_trace(conn, step) do
    assign(conn, :pipeline_trace, (conn.assigns[:pipeline_trace] || []) ++ [step])
  end
end
