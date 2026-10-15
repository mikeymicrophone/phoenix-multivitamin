# Function components and HEEx · 06 · Sequim lavender sachets
#
# Teaches:
# - HEEx class lists drop nil and false, and flatten nested lists
# - Dynamic attributes spread from a map or keyword list
# - class={false} and class={nil} render class="", they are not omitted

defmodule PhoenixMultivitaminWeb.SequimLavenderSachetsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Sequim lavender sachets")
     |> assign(:farm, "Purple Haze Lavender · Sequim")
     |> assign(:distiller, "Mireille")
     |> assign(:grosso_cured?, false)
     |> assign(:hidcote_super?, true)
     |> assign(:show_aria?, true)}
  end

  @impl true
  def handle_event("cure_grosso", _params, socket) do
    {:noreply, assign(socket, :grosso_cured?, true)}
  end

  def handle_event("uncure_grosso", _params, socket) do
    {:noreply, assign(socket, :grosso_cured?, false)}
  end

  def handle_event("hide_aria", _params, socket) do
    {:noreply, assign(socket, :show_aria?, false)}
  end

  attr :cultivar, :string, required: true
  attr :lot, :string, required: true
  attr :cured?, :boolean, default: false
  attr :grade, :atom, values: [:field, :super], default: :field
  attr :id, :string, required: true
  attr :dynamic, :map, default: %{}
  attr :class_override, :any, default: :unset

  def sachet(assigns) do
    ~H"""
    <article
      id={@id}
      class={class_for(@class_override, @cured?, @grade)}
      {@dynamic}
    >
      <h2>{@cultivar}</h2>
      <p>Lot {@lot}</p>
      <p data-field="cure">{if @cured?, do: "cured on the rack", else: "still in the barn"}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 06 · Sequim lavender sachets
      </p>

      <h1>Sequim lavender sachets</h1>
      <p class="lede">
        {@distiller} fills sachets at {@farm}. Grosso and Hidcote Super share
        a class list. Nested lists flatten. False and nil entries drop.
        Harvest metadata is spread as dynamic attributes.
      </p>

      <div class="watch-actions">
        <button id="cure-grosso" type="button" phx-click="cure_grosso">Cure Grosso</button>
        <button id="uncure-grosso" type="button" phx-click="uncure_grosso">Return Grosso to barn</button>
        <button id="hide-aria" type="button" phx-click="hide_aria">Drop Grosso aria</button>
      </div>

      <.sachet
        id="grosso-sachet"
        cultivar="Grosso"
        lot="PH-24-G-11"
        cured?={@grosso_cured?}
        dynamic={
          %{
            "data-field" => "west-five",
            "aria-label" => if(@show_aria?, do: "Grosso sachet from west five")
          }
        }
      />

      <.sachet
        id="hidcote-sachet"
        cultivar="Hidcote Super"
        lot="PH-24-H-4"
        cured?={true}
        grade={:super}
        dynamic={%{tabindex: 0, "data-still": "copper-20"}}
      />

      <.sachet
        id="blank-class-sachet"
        cultivar="Folgate"
        lot="PH-24-F-2"
        class_override={false}
      />
    </Layouts.catalog>
    """
  end

  defp class_for(:unset, cured?, grade) do
    [
      "sachet",
      ["lavender", grade == :super && "super-blue"],
      cured? && "cured",
      nil,
      false
    ]
  end

  defp class_for(override, _cured?, _grade), do: override
end
