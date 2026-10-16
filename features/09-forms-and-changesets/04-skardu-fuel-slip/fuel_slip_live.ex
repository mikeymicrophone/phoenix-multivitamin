# Forms and changesets · 04 · Skardu fuel slip
#
# Teaches:
# - Field errors rendered next to the input

defmodule PhoenixMultivitaminWeb.SkarduFuelSlipLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.SkarduFuelSlip

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      SkarduFuelSlip.changeset(%SkarduFuelSlip{}, %{
        "clerk" => "Nazeer",
        "craft" => "Pilatus PC-24"
      })

    {:ok,
     socket
     |> assign(:page_title, "Skardu fuel slip")
     |> assign(:clerk, "Nazeer")
     |> assign(:craft, "Pilatus PC-24")
     |> assign(:form, to_form(changeset, as: :fuel_slip))}
  end

  @impl true
  def handle_event("validate_slip", %{"fuel_slip" => params}, socket) do
    changeset =
      %SkarduFuelSlip{}
      |> SkarduFuelSlip.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset, as: :fuel_slip))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 04 · Skardu fuel slip
      </p>

      <h1>Skardu fuel slip</h1>
      <p class="lede">
        Clerk {@clerk} files litres for the {@craft} at Skardu. A fat slip
        paints the error beside the litres box.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.form for={@form} id="fuel-slip-form" phx-change="validate_slip">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:litres]} type="number" label="Litres" />
      </.form>
    </Layouts.catalog>
    """
  end
end
