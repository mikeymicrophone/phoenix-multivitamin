# Forms and changesets · 12 · Aitutaki reset form
#
# Teaches:
# - A form that resets after a successful save

defmodule PhoenixMultivitaminWeb.AitutakiResetFormLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.AitutakiLagoonCard

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Aitutaki reset form")
     |> assign(:clerk, "Moana")
     |> assign(:craft, "Embraer EMB-110 Bandeirante")
     |> assign(:last_passengers, nil)
     |> assign(:form, blank_form())}
  end

  @impl true
  def handle_event("save_lagoon", %{"lagoon_card" => params}, socket) do
    changeset =
      %AitutakiLagoonCard{}
      |> AitutakiLagoonCard.changeset(params)
      |> Map.put(:action, :insert)

    socket =
      if changeset.valid? do
        card = Ecto.Changeset.apply_changes(changeset)

        socket
        |> assign(:last_passengers, card.passengers)
        |> assign(:form, blank_form())
      else
        assign(socket, :form, to_form(changeset, as: :lagoon_card))
      end

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 12 · Aitutaki reset form
      </p>

      <h1>Aitutaki reset form</h1>
      <p class="lede">
        Clerk {@clerk} files a {@craft} lagoon hop. A successful stamp
        clears the form.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={@last_passengers} id="last-passengers">{@last_passengers}</p>

      <.form for={@form} id="lagoon-card-form" phx-submit="save_lagoon">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:passengers]} type="number" label="Passengers" />
        <.button id="stamp-lagoon" type="submit">Stamp the hop</.button>
      </.form>
    </Layouts.catalog>
    """
  end

  defp blank_form do
    %AitutakiLagoonCard{}
    |> AitutakiLagoonCard.changeset(%{
      "clerk" => "Moana",
      "craft" => "Embraer EMB-110 Bandeirante"
    })
    |> to_form(as: :lagoon_card)
  end
end
