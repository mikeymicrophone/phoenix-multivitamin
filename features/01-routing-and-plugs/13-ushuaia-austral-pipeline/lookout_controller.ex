defmodule PhoenixMultivitaminWeb.UshuaiaLookoutController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def desk(conn, _params) do
    conn
    |> assign(:page_title, "Ushuaia austral pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:radio_channel, conn.private[:radio_channel])
    |> assign(:clerk, "Pilar")
    |> render(:desk)
  end

  def icing(conn, _params) do
    conn
    |> assign(:page_title, "Ushuaia austral pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:radio_channel, conn.private[:radio_channel])
    |> assign(:clerk, "Pilar")
    |> assign(:watch, "icing")
    |> render(:icing)
  end
end
