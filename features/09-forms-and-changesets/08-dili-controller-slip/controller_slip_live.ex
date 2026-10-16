# Forms and changesets · 08 · Dili controller slip
#
# Teaches:
# - The catalog page is a LiveView; the form posts through a controller

defmodule PhoenixMultivitaminWeb.DiliControllerSlipLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Dili controller slip")
     |> assign(:clerk, "Rosa")
     |> assign(:craft, "IPTN CN-235")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Forms and changesets · 08 · Dili controller slip
      </p>

      <h1>Dili controller slip</h1>
      <p class="lede">
        Clerk {@clerk} files the {@craft} through a controller, not a LiveView.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>

      <p>
        <.link
          id="open-slip-form"
          href={~p"/features/09-forms-and-changesets/08-dili-controller-slip/slips/new"}
        >
          Open the controller form
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
