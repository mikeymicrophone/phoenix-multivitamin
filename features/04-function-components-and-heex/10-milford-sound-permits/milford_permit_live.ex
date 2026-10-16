# Function components and HEEx · 10 · Milford Sound permits
#
# Teaches:
# - Phoenix.Component.assign_new/3, update/3, and to_form/2
# - dynamic_tag/1 for a heading that follows permit class
# - intersperse/1 between party names
# - used_input?/1 stays false until the dispatcher field is changed

defmodule PhoenixMultivitaminWeb.MilfordSoundPermitsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Milford Sound permits")
     |> assign(:airstrip, "Milford Sound airstrip")
     |> assign(:dispatcher, "Ngaio")
     |> assign(:permit_class, "scenic")
     |> assign(:party, ["Ngaio", "Kahu", "Anahera"])
     |> assign(:dispatcher_name, "Ngaio")
     |> assign(:form, to_form(%{}, as: :permit))}
  end

  @impl true
  def handle_event("switch_overnight", _params, socket) do
    {:noreply, assign(socket, :permit_class, "overnight")}
  end

  def handle_event("switch_scenic", _params, socket) do
    {:noreply, assign(socket, :permit_class, "scenic")}
  end

  def handle_event("add_hemi", _params, socket) do
    {:noreply, update(socket, :party, &(&1 ++ ["Hemi"]))}
  end

  def handle_event("validate_dispatcher", %{"permit" => permit_params}, socket) do
    {:noreply, assign(socket, :form, to_form(permit_params, as: :permit))}
  end

  attr :permit_class, :string, required: true
  attr :id, :string, required: true
  slot :inner_block, required: true

  def permit_heading(assigns) do
    assigns =
      assign_new(assigns, :tag, fn %{permit_class: class} ->
        if class == "overnight", do: "h2", else: "h3"
      end)

    ~H"""
    <.dynamic_tag id={@id} tag_name={@tag} class="permit-heading">
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  attr :party, :list, required: true
  attr :id, :string, required: true

  def party_line(assigns) do
    ~H"""
    <p id={@id}>
      <.intersperse :let={flyer} enum={@party}>
        <:separator><span class="muted"> · </span></:separator>
        {flyer}
      </.intersperse>
    </p>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 10 · Milford Sound permits
      </p>

      <h1>Milford Sound permits</h1>
      <p class="lede">
        Dispatcher {@dispatcher} writes scenic and overnight slips at {@airstrip} for
        the Cessna 185. The heading tag follows the permit class.
        Party names are interspersed. The dispatcher field tracks <code>used_input?/1</code>.
      </p>

      <div class="watch-actions">
        <button id="switch-overnight" type="button" phx-click="switch_overnight">
          Overnight slip
        </button>
        <button id="switch-scenic" type="button" phx-click="switch_scenic">Scenic slip</button>
        <button id="add-hemi" type="button" phx-click="add_hemi">Add Hemi</button>
      </div>

      <.permit_heading id="permit-heading" permit_class={@permit_class}>
        Milford Sound · {@permit_class} permit
      </.permit_heading>

      <.party_line id="party-line" party={@party} />

      <.form for={@form} id="dispatcher-form" phx-change="validate_dispatcher">
        <label>
          Dispatcher
          <input
            id="dispatcher-name"
            type="text"
            name={@form[:dispatcher].name}
            value={@form[:dispatcher].value || @dispatcher_name}
          />
        </label>
      </.form>

      <p id="dispatcher-used">
        {if used_input?(@form[:dispatcher]),
          do: "dispatcher field used",
          else: "dispatcher field untouched"}
      </p>
      <p id="party-count">{length(@party)} in the party</p>
    </Layouts.catalog>
    """
  end
end
