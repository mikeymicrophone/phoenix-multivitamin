# Controllers and JSON · 05 · Bariloche Chinook brief
#
# Teaches:
# - put_status(:accepted) then render/3 is 202 with an HTML body
# - Status and body are independent; 202 is not an empty response
# - render/3 receives its assigns as an explicit keyword list

defmodule PhoenixMultivitaminWeb.BarilocheChinookBriefController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, _params) do
    conn
    |> put_status(:accepted)
    |> render(:show,
      page_title: "Bariloche Chinook brief",
      flash: conn.assigns[:flash] || %{},
      officer: "Sofía",
      craft: "CH-47 Chinook",
      valley: "Catedral saddle",
      status_name: "accepted"
    )
  end
end
