# Routing and plugs · 11 · Bergen briefing desk
#
# Teaches:
# - A plug that reads the session can redirect before the action
# - redirect/2 sends the response immediately; without halt/1 the action still runs
# - halt/1 after redirect is what keeps the SID plates in the drawer

defmodule PhoenixMultivitaminWeb.BergenBriefingDeskController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  plug :require_dispatcher when action == :desk
  plug :leaky_dispatcher when action == :leaky_desk

  def roster(conn, _params) do
    conn
    |> assign(:page_title, "Bergen briefing desk")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:station, "Bergen Flesland")
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
    |> assign(:page_title, "Bergen briefing desk")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:station, "Bergen Flesland")
    |> assign(:dispatcher, conn.assigns[:dispatcher] || "the drawer latch")
    |> assign(:plate, "Flesland SID plates")
    |> assign(:plates_opened, true)
    |> render(:desk)
  end

  defp require_dispatcher(conn, _opts) do
    case get_session(conn, :briefing_dispatcher) do
      name when is_binary(name) ->
        assign(conn, :dispatcher, name)

      _ ->
        conn
        |> put_flash(:error, "Sign the roster before you open the briefing desk.")
        |> redirect(to: ~p"/features/01-routing-and-plugs/11-bergen-briefing-desk/roster")
        |> halt()
    end
  end

  defp leaky_dispatcher(conn, _opts) do
    case get_session(conn, :briefing_dispatcher) do
      name when is_binary(name) ->
        assign(conn, :dispatcher, name)

      _ ->
        conn
        |> put_flash(:error, "Sign the roster before you open the briefing desk.")
        |> redirect(to: ~p"/features/01-routing-and-plugs/11-bergen-briefing-desk/roster")
    end
  end
end
