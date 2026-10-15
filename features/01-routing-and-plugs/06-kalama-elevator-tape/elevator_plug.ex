defmodule PhoenixMultivitaminWeb.KalamaElevatorPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    shift =
      case conn.params["shift"] || header_shift(conn) do
        "day" -> "day"
        "swing" -> "swing"
        _ -> "graveyard"
      end

    conn
    |> assign(:shift, shift)
    |> assign(:silo, "Kalama export elevator")
    |> assign(:river, "Columbia River")
  end

  defp header_shift(conn) do
    case get_req_header(conn, "x-elevator-shift") do
      [shift] -> shift
      _ -> nil
    end
  end
end
