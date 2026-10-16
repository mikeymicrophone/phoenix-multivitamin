# Forms and changesets · 07 · Ivalo recover desk
#
# Teaches:
# - phx-auto-recover after a dropped socket

defmodule PhoenixMultivitaminWeb.IvaloRecoverDeskLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.IvaloDeiceCard

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      IvaloDeiceCard.changeset(%IvaloDeiceCard{}, %{
        "clerk" => "Sisko",
        "craft" => "Fokker 50"
      })

    {:ok,
     socket
     |> assign(:page_title, "Ivalo recover desk")
     |> assign(:clerk, "Sisko")
     |> assign(:craft, "Fokker 50")
     |> assign(:recovered?, false)
     |> assign(:form, to_form(changeset, as: :deice_card))}
  end

  @impl true
  def handle_event("validate_deice", %{"deice_card" => params}, socket) do
    {:noreply, assign(socket, :form, form_from(params, :validate))}
  end

  def handle_event("recover_deice", %{"deice_card" => params}, socket) do
    {:noreply,
     socket
     |> assign(:recovered?, true)
     |> assign(:form, form_from(params, :validate))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 07 · Ivalo recover desk
      </p>

      <h1>Ivalo recover desk</h1>
      <p class="lede">
        Clerk {@clerk} keeps a {@craft} deice card at Ivalo. A dropped socket
        recovers the fluid through phx-auto-recover.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="recover-state">{if @recovered?, do: "recovered", else: "fresh"}</p>

      <.form
        for={@form}
        id="deice-card-form"
        phx-change="validate_deice"
        phx-auto-recover="recover_deice"
      >
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:fluid]} label="Fluid" />
        <.input field={@form[:tank_c]} type="number" label="Tank Celsius" />
      </.form>
    </Layouts.catalog>
    """
  end

  defp form_from(params, action) do
    %IvaloDeiceCard{}
    |> IvaloDeiceCard.changeset(params)
    |> Map.put(:action, action)
    |> to_form(as: :deice_card)
  end
end
