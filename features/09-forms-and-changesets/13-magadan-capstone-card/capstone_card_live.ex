# Forms and changesets · 13 · Magadan capstone card
#
# Teaches:
# - Live validation, nested fields, and a save that writes

defmodule PhoenixMultivitaminWeb.MagadanCapstoneCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.MagadanFuelCard
  alias PhoenixMultivitamin.MagadanPayload
  alias PhoenixMultivitamin.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Magadan capstone card")
     |> assign(:clerk, "Stepan")
     |> assign(:craft, "Antonov An-124")
     |> assign(:written_litres, nil)
     |> assign(:form, blank_form())}
  end

  @impl true
  def handle_event("validate_card", %{"fuel_card" => params}, socket) do
    {:noreply, assign(socket, :form, form_from(params, :validate))}
  end

  def handle_event("save_card", %{"fuel_card" => params}, socket) do
    changeset = built(params, :insert)

    socket =
      case Repo.insert(changeset) do
        {:ok, card} ->
          socket
          |> assign(:written_litres, card.litres)
          |> assign(:form, blank_form())

        {:error, failed} ->
          assign(socket, :form, to_form(failed, as: :fuel_card))
      end

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 13 · Magadan capstone card
      </p>

      <h1>Magadan capstone card</h1>
      <p class="lede">
        Clerk {@clerk} live-validates a nested {@craft} fuel and payload card
        and writes it at Magadan.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={@written_litres} id="written-litres">{@written_litres}</p>

      <.form
        for={@form}
        id="fuel-card-form"
        phx-change="validate_card"
        phx-submit="save_card"
      >
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:litres]} type="number" label="Litres" />
        <.inputs_for :let={payload} field={@form[:payload]}>
          <.input field={payload[:cargo_kg]} type="number" label="Cargo kilograms" />
          <.input field={payload[:souls]} type="number" label="Souls" />
        </.inputs_for>
        <.button id="write-card" type="submit">Write the card</.button>
      </.form>
    </Layouts.catalog>
    """
  end

  defp blank_form do
    %MagadanFuelCard{payload: %MagadanPayload{}}
    |> MagadanFuelCard.changeset(%{
      "clerk" => "Stepan",
      "craft" => "Antonov An-124"
    })
    |> to_form(as: :fuel_card)
  end

  defp form_from(params, action) do
    to_form(built(params, action), as: :fuel_card)
  end

  defp built(params, action) do
    %MagadanFuelCard{payload: %MagadanPayload{}}
    |> MagadanFuelCard.changeset(params)
    |> Map.put(:action, action)
  end
end
