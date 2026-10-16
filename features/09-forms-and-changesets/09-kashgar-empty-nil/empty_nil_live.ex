# Forms and changesets · 09 · Kashgar empty nil
#
# Teaches:
# - Casting empty strings to nil

defmodule PhoenixMultivitaminWeb.KashgarEmptyNilLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.KashgarEnduranceCard

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      KashgarEnduranceCard.changeset(%KashgarEnduranceCard{}, %{
        "clerk" => "Dilbar",
        "craft" => "Harbin Y-12"
      })

    {:ok,
     socket
     |> assign(:page_title, "Kashgar empty nil")
     |> assign(:clerk, "Dilbar")
     |> assign(:craft, "Harbin Y-12")
     |> assign(:filed_endurance, :blank)
     |> assign(:form, to_form(changeset, as: :endurance_card))}
  end

  @impl true
  def handle_event("file_endurance", %{"endurance_card" => params}, socket) do
    changeset =
      %KashgarEnduranceCard{}
      |> KashgarEnduranceCard.changeset(params)
      |> Map.put(:action, :insert)

    card = Ecto.Changeset.apply_changes(changeset)

    {:noreply,
     socket
     |> assign(:filed_endurance, card.endurance_min)
     |> assign(:form, to_form(changeset, as: :endurance_card))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 09 · Kashgar empty nil
      </p>

      <h1>Kashgar empty nil</h1>
      <p class="lede">
        Clerk {@clerk} files endurance minutes for the {@craft} at Kashgar.
        An empty box casts to nil, not an empty string.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="filed-endurance">
        {if @filed_endurance == :blank,
          do: "not filed",
          else: if(@filed_endurance, do: @filed_endurance, else: "nil")}
      </p>

      <.form for={@form} id="endurance-card-form" phx-submit="file_endurance">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:endurance_min]} type="number" label="Endurance minutes" />
        <.button id="file-endurance" type="submit">File endurance</.button>
      </.form>
    </Layouts.catalog>
    """
  end
end
