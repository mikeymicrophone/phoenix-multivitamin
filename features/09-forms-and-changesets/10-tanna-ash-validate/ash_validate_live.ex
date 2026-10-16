# Forms and changesets · 10 · Tanna ash validate
#
# Teaches:
# - Action :validate versus :save on the changeset

defmodule PhoenixMultivitaminWeb.TannaAshValidateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.TannaAshCard

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      TannaAshCard.changeset(%TannaAshCard{}, %{
        "clerk" => "Leipakoa",
        "craft" => "Britten-Norman BN-2 Islander"
      })

    {:ok,
     socket
     |> assign(:page_title, "Tanna ash validate")
     |> assign(:clerk, "Leipakoa")
     |> assign(:craft, "Britten-Norman BN-2 Islander")
     |> assign(:form_action, nil)
     |> assign(:posted_ash, nil)
     |> assign(:form, to_form(changeset, as: :ash_card))}
  end

  @impl true
  def handle_event("validate_ash", %{"ash_card" => params}, socket) do
    {:noreply, put_form(socket, params, :validate, posted_ash: socket.assigns.posted_ash)}
  end

  def handle_event("save_ash", %{"ash_card" => params}, socket) do
    changeset = built(params, :insert)

    socket =
      if changeset.valid? do
        card = Ecto.Changeset.apply_changes(changeset)
        put_form(socket, params, :insert, posted_ash: card.ash_ft)
      else
        put_form(socket, params, :insert, posted_ash: nil)
      end

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 10 · Tanna ash validate
      </p>

      <h1>Tanna ash validate</h1>
      <p class="lede">
        Clerk {@clerk} files Yasur ash for the {@craft}. Change is :validate.
        Submit is :insert.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="form-action">{@form_action || "none"}</p>
      <p :if={@posted_ash} id="posted-ash">{@posted_ash}</p>

      <.form
        for={@form}
        id="ash-card-form"
        phx-change="validate_ash"
        phx-submit="save_ash"
      >
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:ash_ft]} type="number" label="Ash feet" />
        <.button id="file-ash" type="submit">File the ash</.button>
      </.form>
    </Layouts.catalog>
    """
  end

  defp put_form(socket, params, action, posted_ash: posted_ash) do
    socket
    |> assign(:form_action, action)
    |> assign(:posted_ash, posted_ash)
    |> assign(:form, to_form(built(params, action), as: :ash_card))
  end

  defp built(params, action) do
    %TannaAshCard{}
    |> TannaAshCard.changeset(params)
    |> Map.put(:action, action)
  end
end
