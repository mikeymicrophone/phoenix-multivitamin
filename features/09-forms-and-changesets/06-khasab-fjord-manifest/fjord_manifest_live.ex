# Forms and changesets · 06 · Khasab fjord manifest
#
# Teaches:
# - select, checkbox, and textarea from core inputs

defmodule PhoenixMultivitaminWeb.KhasabFjordManifestLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.KhasabFjordManifest

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      KhasabFjordManifest.changeset(%KhasabFjordManifest{}, %{
        "clerk" => "Thuraya",
        "craft" => "Let L-410"
      })

    {:ok,
     socket
     |> assign(:page_title, "Khasab fjord manifest")
     |> assign(:clerk, "Thuraya")
     |> assign(:craft, "Let L-410")
     |> assign(:form, to_form(changeset, as: :fjord_manifest))}
  end

  @impl true
  def handle_event("validate_manifest", %{"fjord_manifest" => params}, socket) do
    changeset =
      %KhasabFjordManifest{}
      |> KhasabFjordManifest.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset, as: :fjord_manifest))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 06 · Khasab fjord manifest
      </p>

      <h1>Khasab fjord manifest</h1>
      <p class="lede">
        Clerk {@clerk} logs the {@craft} into a Musandam fjord with a select,
        a night-vision box, and a remarks pad.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <.form for={@form} id="fjord-manifest-form" phx-change="validate_manifest">
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input
          field={@form[:fjord]}
          type="select"
          label="Fjord"
          prompt="Pick a fjord"
          options={["Khasab creek", "Kumzar", "Musandam tip"]}
        />
        <.input field={@form[:night_vision]} type="checkbox" label="Night vision" />
        <.input field={@form[:remarks]} type="textarea" label="Remarks" />
      </.form>
    </Layouts.catalog>
    """
  end
end
