# Routing and plugs · 05 · Willapa seed barge office
#
# Teaches:
# - plug Module, opts on a controller passes a keyword list into init/1
# - init/1 transforms that keyword list; call/2 receives the transformed map
# - Domain options stay in this folder, not in the main router

defmodule PhoenixMultivitaminWeb.WillapaSeedBargeController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  plug PhoenixMultivitaminWeb.WillapaSeedBargePlug,
    landing: "Nahcotta",
    crop: "Pacific oyster spat",
    barge: "Oyster Queen"

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Willapa seed barge office")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> render(:show)
  end
end
