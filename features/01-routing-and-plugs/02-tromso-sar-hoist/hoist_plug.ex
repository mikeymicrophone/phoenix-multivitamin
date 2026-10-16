defmodule PhoenixMultivitaminWeb.TromsoSarHoistPlug do
  @moduledoc false
  import Plug.Conn
  import Phoenix.Controller, only: [put_view: 2, render: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "x-winch-ticket") do
      ["hoist-17"] ->
        conn
        |> assign(:pad, "Tromsø SAR pad")
        |> assign(:hoist, "Sea King winch 17")
        |> assign(:winch_operator, "Sigrid")

      _ ->
        conn
        |> assign(:page_title, "Tromsø SAR hoist")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> assign(:pad, "Tromsø SAR pad")
        |> put_status(:unauthorized)
        |> put_view(html: PhoenixMultivitaminWeb.TromsoSarHoistHTML)
        |> render(:locked)
        |> halt()
    end
  end
end
