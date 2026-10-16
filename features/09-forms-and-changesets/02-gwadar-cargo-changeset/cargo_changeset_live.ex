# Forms and changesets · 02 · Gwadar cargo changeset
#
# Teaches:
# - phx-change validating on every keystroke

defmodule PhoenixMultivitaminWeb.GwadarCargoChangesetLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.GwadarCargoCard

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      GwadarCargoCard.changeset(%GwadarCargoCard{}, %{
        "clerk" => "Parveen",
        "craft" => "Antonov An-12"
      })

    {:ok,
     socket
     |> assign(:page_title, "Gwadar cargo changeset")
     |> assign(:clerk, "Parveen")
     |> assign(:craft, "Antonov An-12")
     |> assign(:form, to_form(changeset, as: :cargo_card))}
  end

  @impl true
  def handle_event("validate_pallet", %{"cargo_card" => params}, socket) do
    changeset =
      %GwadarCargoCard{}
      |> GwadarCargoCard.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset, as: :cargo_card))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 02 · Gwadar cargo changeset
      </p>

      <h1>Gwadar cargo changeset</h1>
      <p class="lede">
        Clerk {@clerk} validates an {@craft} pallet on every keystroke at Gwadar.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.form for={@form} id="cargo-card-form" phx-change="validate_pallet">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:pallet_kg]} type="number" label="Pallet kilograms" />
      </.form>
    </Layouts.catalog>
    """
  end
end
