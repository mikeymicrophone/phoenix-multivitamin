# Function components and HEEx · 06 · Cranfield SAF sachets
#
# Teaches:
# - HEEx class lists drop nil and false, and flatten nested lists
# - Dynamic attributes spread from a map or keyword list
# - class={false} and class={nil} render class="", they are not omitted

defmodule PhoenixMultivitaminWeb.CranfieldSafSachetsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Cranfield SAF sachets")
     |> assign(:lab, "Cranfield SAF lab")
     |> assign(:chemist, "Iona")
     |> assign(:hefa_certified?, false)
     |> assign(:ft_drop_in?, true)
     |> assign(:show_aria?, true)}
  end

  @impl true
  def handle_event("certify_hefa", _params, socket) do
    {:noreply, assign(socket, :hefa_certified?, true)}
  end

  def handle_event("uncertify_hefa", _params, socket) do
    {:noreply, assign(socket, :hefa_certified?, false)}
  end

  def handle_event("hide_aria", _params, socket) do
    {:noreply, assign(socket, :show_aria?, false)}
  end

  attr :pathway, :string, required: true
  attr :lot, :string, required: true
  attr :certified?, :boolean, default: false
  attr :grade, :atom, values: [:lab, :drop_in], default: :lab
  attr :id, :string, required: true
  attr :dynamic, :map, default: %{}
  attr :class_override, :any, default: :unset

  def sachet(assigns) do
    ~H"""
    <article
      id={@id}
      class={class_for(@class_override, @certified?, @grade)}
      {@dynamic}
    >
      <h2>{@pathway}</h2>
      <p>Lot {@lot}</p>
      <p data-field="status">{if @certified?, do: "certified drop-in", else: "still in the flask"}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 06 · Cranfield SAF sachets
      </p>

      <h1>Cranfield SAF sachets</h1>
      <p class="lede">
        {@chemist} fills sachets at {@lab}. HEFA and FT share
        a class list. Nested lists flatten. False and nil entries drop.
        Sample metadata is spread as dynamic attributes.
      </p>

      <div class="watch-actions">
        <button id="certify-hefa" type="button" phx-click="certify_hefa">Certify HEFA</button>
        <button id="uncertify-hefa" type="button" phx-click="uncertify_hefa">Return HEFA to flask</button>
        <button id="hide-aria" type="button" phx-click="hide_aria">Drop HEFA aria</button>
      </div>

      <.sachet
        id="hefa-sachet"
        pathway="HEFA"
        lot="CF-24-H-11"
        certified?={@hefa_certified?}
        dynamic={
          %{
            "data-field" => "lab-two",
            "aria-label" => if(@show_aria?, do: "HEFA sachet from lab two")
          }
        }
      />

      <.sachet
        id="ft-sachet"
        pathway="FT"
        lot="CF-24-F-4"
        certified?={true}
        grade={:drop_in}
        dynamic={%{tabindex: 0, "data-reactor": "ft-20"}}
      />

      <.sachet
        id="blank-class-sachet"
        pathway="alcohol-to-jet"
        lot="CF-24-A-2"
        class_override={false}
      />
    </Layouts.catalog>
    """
  end

  defp class_for(:unset, certified?, grade) do
    [
      "sachet",
      ["saf", grade == :drop_in && "drop-in"],
      certified? && "certified",
      nil,
      false
    ]
  end

  defp class_for(override, _certified?, _grade), do: override
end
