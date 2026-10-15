# Function components and HEEx · 10 · Kaleetan trail permits
#
# Teaches:
# - Phoenix.Component.assign_new/3, update/3, and to_form/2
# - dynamic_tag/1 for a heading that follows wilderness class
# - intersperse/1 between party names
# - used_input?/1 stays false until the ranger field is changed

defmodule PhoenixMultivitaminWeb.KaleetanTrailPermitsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Kaleetan trail permits")
     |> assign(:trailhead, "Denny Creek · Alpine Lakes Wilderness")
     |> assign(:ranger, "Thea")
     |> assign(:wilderness_class, "day")
     |> assign(:party, ["Thea", "Nils", "Petra"])
     |> assign(:ranger_name, "Thea")
     |> assign(:form, to_form(%{}, as: :permit))}
  end

  @impl true
  def handle_event("switch_overnight", _params, socket) do
    {:noreply, assign(socket, :wilderness_class, "overnight")}
  end

  def handle_event("switch_day", _params, socket) do
    {:noreply, assign(socket, :wilderness_class, "day")}
  end

  def handle_event("add_soren", _params, socket) do
    {:noreply, update(socket, :party, &(&1 ++ ["Soren"]))}
  end

  def handle_event("validate_ranger", %{"permit" => permit_params}, socket) do
    {:noreply, assign(socket, :form, to_form(permit_params, as: :permit))}
  end

  attr :wilderness_class, :string, required: true
  attr :id, :string, required: true
  slot :inner_block, required: true

  def permit_heading(assigns) do
    assigns =
      assign_new(assigns, :tag, fn %{wilderness_class: class} ->
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
      <.intersperse :let={hiker} enum={@party}>
        <:separator><span class="muted"> · </span></:separator>
        {hiker}
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
        · Function components and HEEx · 10 · Kaleetan trail permits
      </p>

      <h1>Kaleetan trail permits</h1>
      <p class="lede">
        Ranger {@ranger} writes day and overnight slips at {@trailhead} for
        Kaleetan Peak. The heading tag follows the wilderness class.
        Party names are interspersed. The ranger field tracks <code>used_input?/1</code>.
      </p>

      <div class="watch-actions">
        <button id="switch-overnight" type="button" phx-click="switch_overnight">
          Overnight slip
        </button>
        <button id="switch-day" type="button" phx-click="switch_day">Day slip</button>
        <button id="add-soren" type="button" phx-click="add_soren">Add Soren</button>
      </div>

      <.permit_heading id="permit-heading" wilderness_class={@wilderness_class}>
        Kaleetan Peak · {@wilderness_class} permit
      </.permit_heading>

      <.party_line id="party-line" party={@party} />

      <.form for={@form} id="ranger-form" phx-change="validate_ranger">
        <label>
          Ranger
          <input
            id="ranger-name"
            type="text"
            name={@form[:ranger].name}
            value={@form[:ranger].value || @ranger_name}
          />
        </label>
      </.form>

      <p id="ranger-used">
        {if used_input?(@form[:ranger]), do: "ranger field used", else: "ranger field untouched"}
      </p>
      <p id="party-count">{length(@party)} in the party</p>
    </Layouts.catalog>
    """
  end
end
