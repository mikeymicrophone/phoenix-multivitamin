# Controllers and JSON · 12 · Baltra biosecurity pass
#
# Teaches:
# - Multiple clauses of show/2 match on the pass kind
# - The last clause is the unknown-kind fallback
# - Clause order matters; galapagos is not transit

defmodule PhoenixMultivitaminWeb.BaltraBiosecurityPassController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, %{"kind" => "galapagos"}) do
    render_pass(conn, %{
      kind: "galapagos",
      inspector: "Paz",
      craft: "Avro RJ100",
      boots: "scrubbed",
      fruit: "refused"
    })
  end

  def show(conn, %{"kind" => "transit"}) do
    render_pass(conn, %{
      kind: "transit",
      inspector: "Paz",
      craft: "Avro RJ100",
      boots: "stay-on",
      fruit: "sealed"
    })
  end

  def show(conn, %{"kind" => kind}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "unknown_pass", kind: kind, inspector: "Paz"})
  end

  defp render_pass(conn, pass) do
    conn
    |> assign(:page_title, "Baltra biosecurity pass")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:pass, pass)
    |> render(:show)
  end
end
