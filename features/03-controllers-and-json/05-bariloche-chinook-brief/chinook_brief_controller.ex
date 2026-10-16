# Controllers and JSON · 05 · Bariloche Chinook brief
#
# Teaches:
# - put_status(:accepted) then render/3 is 202 with an HTML body
# - Status and body are independent; 202 is not an empty response

defmodule PhoenixMultivitaminWeb.BarilocheChinookBriefController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, _params) do
    conn
    |> put_status(:accepted)
    |> assign(:page_title, "Bariloche Chinook brief")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:officer, "Sofía")
    |> assign(:craft, "CH-47 Chinook")
    |> assign(:valley, "Catedral saddle")
    |> assign(:status_name, "accepted")
    |> render(:show)
  end
end
