# Forms and changesets · 05 · Hiva Oa tow embed
#
# Teaches:
# - A nested embed in the form

defmodule PhoenixMultivitaminWeb.HivaOaTowEmbedLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.HivaOaTow
  alias PhoenixMultivitamin.HivaOaTowCard

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      HivaOaTowCard.changeset(%HivaOaTowCard{tow: %HivaOaTow{}}, %{
        "clerk" => "Heiata",
        "craft" => "Cessna 185 Skywagon"
      })

    {:ok,
     socket
     |> assign(:page_title, "Hiva Oa tow embed")
     |> assign(:clerk, "Heiata")
     |> assign(:craft, "Cessna 185 Skywagon")
     |> assign(:form, to_form(changeset, as: :tow_card))}
  end

  @impl true
  def handle_event("validate_tow", %{"tow_card" => params}, socket) do
    changeset =
      %HivaOaTowCard{tow: %HivaOaTow{}}
      |> HivaOaTowCard.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset, as: :tow_card))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 05 · Hiva Oa tow embed
      </p>

      <h1>Hiva Oa tow embed</h1>
      <p class="lede">
        Clerk {@clerk} nests a lagoon tow inside the {@craft} card at Hiva Oa.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.form for={@form} id="tow-card-form" phx-change="validate_tow">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.inputs_for :let={tow} field={@form[:tow]}>
          <.input field={tow[:pilot]} label="Tow pilot" />
          <.input field={tow[:rope_m]} type="number" label="Rope metres" />
        </.inputs_for>
      </.form>
    </Layouts.catalog>
    """
  end
end
