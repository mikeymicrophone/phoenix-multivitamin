defmodule PhoenixMultivitaminWeb.CapeFlatteryLookoutPlug do
  @moduledoc false
  import Plug.Conn
  import Phoenix.Controller, only: [put_view: 2, render: 2]

  alias PhoenixMultivitaminWeb.CapeFlatteryCapePlug

  def init(opts), do: opts

  def call(conn, _opts) do
    conn =
      conn
      |> assign(:lookout, "Tatoosh Island lookout")
      |> put_private(:radio_channel, "tatoosh-radio")
      |> CapeFlatteryCapePlug.stamp_trace("lookout")

    case get_req_header(conn, "x-lookout-ticket") do
      ["tatoosh-clear"] ->
        assign(conn, :ticket, "tatoosh-clear")

      _ ->
        conn
        |> assign(:page_title, "Cape Flattery pipeline")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> put_status(:forbidden)
        |> put_view(html: PhoenixMultivitaminWeb.CapeFlatteryLookoutHTML)
        |> render(:denied)
        |> halt()
    end
  end
end
