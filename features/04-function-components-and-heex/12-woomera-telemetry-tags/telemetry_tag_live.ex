# Function components and HEEx · 12 · Woomera telemetry tags
#
# Teaches:
# - HEEx interpolates binaries as escaped HTML
# - raw/1 and {:safe, _} skip escaping
# - Attribute interpolation escapes quotes so a note cannot break out of the attr

defmodule PhoenixMultivitaminWeb.WoomeraTelemetryTagsLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Woomera telemetry tags")
     |> assign(:range, "Woomera range")
     |> assign(:tagger, "Darcy")
     |> assign(:note, ~s|<range-stamp lot="WO-24-8">apogee beacon</range-stamp>|)
     |> assign(:glyph, {:safe, "<span id=\"range-glyph\">WO</span>"})
     |> assign(:show_raw?, false)}
  end

  @impl true
  def handle_event("print_raw_note", _params, socket) do
    {:noreply, assign(socket, :show_raw?, true)}
  end

  def handle_event("print_escaped_note", _params, socket) do
    {:noreply, assign(socket, :show_raw?, false)}
  end

  attr :code, :string, required: true
  attr :note, :string, required: true
  attr :glyph, :any, required: true
  attr :raw_note?, :boolean, default: false
  attr :id, :string, required: true

  def telemetry_tag(assigns) do
    ~H"""
    <article id={@id} class="scenario" data-note={@note}>
      <h2>Brant {@code}</h2>
      <p id={"#{@id}-note"}>
        <%= if @raw_note? do %>
          {raw(@note)}
        <% else %>
          {@note}
        <% end %>
      </p>
      <p id={"#{@id}-glyph"}>{@glyph}</p>
    </article>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        · Function components and HEEx · 12 · Woomera telemetry tags
      </p>

      <h1>Woomera telemetry tags</h1>
      <p class="lede">
        {@tagger} tags Black Brant sounding rockets at {@range}. Range-stamp
        notes look like tags. Interpolating the note escapes it. Printing it
        raw would inject markup. The range glyph is a trusted safe HTML tuple.
      </p>

      <div class="watch-actions">
        <button id="print-raw-note" type="button" phx-click="print_raw_note">Print note raw</button>
        <button id="print-escaped-note" type="button" phx-click="print_escaped_note">
          Print note escaped
        </button>
      </div>

      <.telemetry_tag
        id="brant-tag"
        code="WO-4418"
        note={@note}
        glyph={@glyph}
        raw_note?={@show_raw?}
      />
    </Layouts.catalog>
    """
  end
end
