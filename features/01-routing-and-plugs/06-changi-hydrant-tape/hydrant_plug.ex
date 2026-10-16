defmodule PhoenixMultivitaminWeb.ChangiHydrantPlug do
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
    |> assign(:hydrant, "Changi hydrant pit 12")
    |> assign(:apron, "taxiway N")
  end

  defp header_shift(conn) do
    case get_req_header(conn, "x-hydrant-shift") do
      [shift] -> shift
      _ -> nil
    end
  end
end
