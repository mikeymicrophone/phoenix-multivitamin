# Forms and changesets · 01 · Oymyakon frost form
#
# Teaches:
# - to_form/1 wrapping a changeset

defmodule PhoenixMultivitaminWeb.OymyakonFrostFormLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.OymyakonFrostSlot

  @impl true
  def mount(_params, _session, socket) do
    changeset = OymyakonFrostSlot.changeset(%OymyakonFrostSlot{}, %{})

    {:ok,
     socket
     |> assign(:page_title, "Oymyakon frost form")
     |> assign(:clerk, "Tuyara")
     |> assign(:craft, "Antonov An-2")
     |> assign(:form, to_form(changeset, as: :frost_slot))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 01 · Oymyakon frost form
      </p>

      <h1>Oymyakon frost form</h1>
      <p class="lede">
        Clerk {@clerk} files a frost-delay slot for the {@craft} at Oymyakon.
        The form is a changeset wrapped by to_form.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.form for={@form} id="frost-slot-form">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:delay_min]} type="number" label="Delay minutes" />
      </.form>
    </Layouts.catalog>
    """
  end
end
