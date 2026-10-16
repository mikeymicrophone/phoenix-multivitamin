# Forms and changesets · 08 · Dili controller slip
#
# Teaches:
# - A form that posts through a controller, not a LiveView

defmodule PhoenixMultivitaminWeb.DiliControllerSlipController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  alias PhoenixMultivitamin.DiliCnSlip

  def new(conn, _params) do
    form =
      %DiliCnSlip{}
      |> DiliCnSlip.changeset(%{"clerk" => "Rosa", "craft" => "IPTN CN-235"})
      |> Phoenix.Component.to_form(as: :cn_slip)

    conn
    |> assign(:page_title, "Dili controller slip")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:clerk, "Rosa")
    |> assign(:craft, "IPTN CN-235")
    |> assign(:form, form)
    |> render(:new)
  end

  def create(conn, %{"cn_slip" => params}) do
    changeset = DiliCnSlip.changeset(%DiliCnSlip{}, params)

    if changeset.valid? do
      slip = Ecto.Changeset.apply_changes(changeset)

      redirect(conn,
        to:
          ~p"/features/09-forms-and-changesets/08-dili-controller-slip/slips/#{slip.destination}"
      )
    else
      form =
        changeset
        |> Map.put(:action, :insert)
        |> Phoenix.Component.to_form(as: :cn_slip)

      conn
      |> assign(:page_title, "Dili controller slip")
      |> assign(:flash, conn.assigns[:flash] || %{})
      |> assign(:clerk, "Rosa")
      |> assign(:craft, "IPTN CN-235")
      |> assign(:form, form)
      |> render(:new)
    end
  end

  def show(conn, %{"destination" => destination}) do
    conn
    |> assign(:page_title, "Dili controller slip")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:clerk, "Rosa")
    |> assign(:craft, "IPTN CN-235")
    |> assign(:destination, destination)
    |> render(:show)
  end
end
