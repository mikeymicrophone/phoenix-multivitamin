defmodule PhoenixMultivitaminWeb.CapeFlatteryLookoutController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def desk(conn, _params) do
    conn
    |> assign(:page_title, "Cape Flattery pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:radio_channel, conn.private[:radio_channel])
    |> assign(:keeper, "Chenoa")
    |> render(:desk)
  end

  def fog(conn, _params) do
    conn
    |> assign(:page_title, "Cape Flattery pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:radio_channel, conn.private[:radio_channel])
    |> assign(:keeper, "Nessa")
    |> assign(:watch, "fog")
    |> render(:fog)
  end
end
