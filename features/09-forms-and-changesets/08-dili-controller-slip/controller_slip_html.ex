defmodule PhoenixMultivitaminWeb.DiliControllerSlipHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def new(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 08 · Dili controller slip
      </p>

      <h1>Dili controller slip</h1>
      <p class="lede">
        Clerk {@clerk} posts the {@craft} slip through the controller.
      </p>

      <.form
        for={@form}
        id="cn-slip-form"
        method="post"
        action={~p"/features/09-forms-and-changesets/08-dili-controller-slip/slips"}
      >
        <input type="hidden" name="_csrf_token" value={get_csrf_token()} />
        <.input field={@form[:clerk]} label="Clerk" />
        <.input field={@form[:craft]} label="Craft" />
        <.input field={@form[:destination]} label="Destination" />
        <.button id="file-slip" type="submit">File the slip</.button>
      </.form>
    </Layouts.catalog>
    """
  end

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 08 · Dili controller slip
      </p>

      <h1>Dili controller slip</h1>
      <p class="lede">
        Clerk {@clerk} filed the {@craft} toward {@destination}.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p id="slip-destination">{@destination}</p>
    </Layouts.catalog>
    """
  end
end
