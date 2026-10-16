# Forms and changesets · 03 · Maun delta weight
#
# Teaches:
# - phx-submit persisting only a valid card

defmodule PhoenixMultivitaminWeb.MaunDeltaWeightLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.MaunWeightCard

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      MaunWeightCard.changeset(%MaunWeightCard{}, %{
        "clerk" => "Kagiso",
        "craft" => "GippsAero GA8 Airvan"
      })

    {:ok,
     socket
     |> assign(:page_title, "Maun delta weight")
     |> assign(:clerk, "Kagiso")
     |> assign(:craft, "GippsAero GA8 Airvan")
     |> assign(:posted_card, nil)
     |> assign(:form, to_form(changeset, as: :weight_card))}
  end

  @impl true
  def handle_event("save_weight", %{"weight_card" => params}, socket) do
    changeset =
      %MaunWeightCard{}
      |> MaunWeightCard.changeset(params)
      |> Map.put(:action, :insert)

    socket =
      if changeset.valid? do
        card = Ecto.Changeset.apply_changes(changeset)

        socket
        |> assign(:posted_card, card)
        |> assign(:form, to_form(changeset, as: :weight_card))
      else
        assign(socket, :form, to_form(changeset, as: :weight_card))
      end

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 03 · Maun delta weight
      </p>

      <h1>Maun delta weight</h1>
      <p class="lede">
        Clerk {@clerk} stamps an {@craft} safari weight at Maun only when the
        card is valid.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.form for={@form} id="weight-card-form" phx-submit="save_weight">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:souls]} type="number" label="Souls on board" />
        <.button id="stamp-weight" type="submit">Stamp the weight</.button>
      </.form>

      <p :if={@posted_card} id="posted-souls">{@posted_card.souls}</p>
    </Layouts.catalog>
    """
  end
end
