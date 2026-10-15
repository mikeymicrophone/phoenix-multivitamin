defmodule PhoenixMultivitaminWeb.PortTownsendHoistPlug do
  @moduledoc false
  import Plug.Conn
  import Phoenix.Controller, only: [put_view: 2, render: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "x-boat-yard-ticket") do
      ["hoist-17"] ->
        conn
        |> assign(:yard, "Port Townsend Shipwrights Co-op")
        |> assign(:hoist, "Travelift 17")
        |> assign(:dispatcher, "Hollis")

      _ ->
        conn
        |> assign(:page_title, "Port Townsend hoist dispatch")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> assign(:yard, "Port Townsend Shipwrights Co-op")
        |> put_status(:unauthorized)
        |> put_view(html: PhoenixMultivitaminWeb.PortTownsendHoistDispatchHTML)
        |> render(:locked)
        |> halt()
    end
  end
end
