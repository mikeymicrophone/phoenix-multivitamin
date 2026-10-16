# Routing and plugs · 05 · Shannon avgas office
#
# Teaches:
# - plug Module, opts on a controller passes a keyword list into init/1
# - init/1 transforms that keyword list; call/2 receives the transformed map
# - Domain options stay in this folder, not in the main router

defmodule PhoenixMultivitaminWeb.ShannonAvgasController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  plug PhoenixMultivitaminWeb.ShannonAvgasPlug,
    apron: "Shannon",
    grade: "100LL",
    bowser: "Avgas 1"

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Shannon avgas office")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> render(:show)
  end
end
