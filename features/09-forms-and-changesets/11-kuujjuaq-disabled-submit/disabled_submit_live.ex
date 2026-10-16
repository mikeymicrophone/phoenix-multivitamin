# Forms and changesets · 11 · Kuujjuaq disabled submit
#
# Teaches:
# - Disabled submit until the changeset is valid

defmodule PhoenixMultivitaminWeb.KuujjuaqDisabledSubmitLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.KuujjuaqIceCard

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      KuujjuaqIceCard.changeset(%KuujjuaqIceCard{}, %{
        "clerk" => "Elisapie",
        "craft" => "Hawker Siddeley HS 748"
      })

    {:ok,
     socket
     |> assign(:page_title, "Kuujjuaq disabled submit")
     |> assign(:clerk, "Elisapie")
     |> assign(:craft, "Hawker Siddeley HS 748")
     |> assign(:card_valid?, changeset.valid?)
     |> assign(:form, to_form(changeset, as: :ice_card))}
  end

  @impl true
  def handle_event("validate_ice", %{"ice_card" => params}, socket) do
    changeset =
      %KuujjuaqIceCard{}
      |> KuujjuaqIceCard.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:card_valid?, changeset.valid?)
     |> assign(:form, to_form(changeset, as: :ice_card))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 11 · Kuujjuaq disabled submit
      </p>

      <h1>Kuujjuaq disabled submit</h1>
      <p class="lede">
        Clerk {@clerk} cannot stamp the {@craft} ice card until the millimetres
        are valid.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="card-valid">{if @card_valid?, do: "valid", else: "invalid"}</p>

      <.form for={@form} id="ice-card-form" phx-change="validate_ice">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:ice_mm]} type="number" label="Ice millimetres" />
        <.button id="stamp-ice" type="submit" disabled={not @card_valid?}>
          Stamp the ice
        </.button>
      </.form>
    </Layouts.catalog>
    """
  end
end
