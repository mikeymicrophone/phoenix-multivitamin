defmodule PhoenixMultivitaminWeb.UshuaiaLookoutPlug do
  @moduledoc false
  import Plug.Conn
  import Phoenix.Controller, only: [put_view: 2, render: 2]

  alias PhoenixMultivitaminWeb.UshuaiaAustralPlug

  def init(opts), do: opts

  def call(conn, _opts) do
    conn =
      conn
      |> assign(:lookout, "Martial glacier lookout")
      |> put_private(:radio_channel, "austral-radio")
      |> UshuaiaAustralPlug.stamp_trace("lookout")

    case get_req_header(conn, "x-lookout-ticket") do
      ["austral-clear"] ->
        assign(conn, :ticket, "austral-clear")

      _ ->
        conn
        |> assign(:page_title, "Ushuaia austral pipeline")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> put_status(:forbidden)
        |> put_view(html: PhoenixMultivitaminWeb.UshuaiaLookoutHTML)
        |> render(:denied)
        |> halt()
    end
  end
end
