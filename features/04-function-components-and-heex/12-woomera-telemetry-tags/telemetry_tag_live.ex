# Function components and HEEx · 12 · Woomera telemetry tags
#
# Teaches:
# - HEEx interpolates binaries as escaped HTML
# - raw/1 and {:safe, _} skip escaping
# - Attribute interpolation escapes quotes so a note cannot break out of the attr
# - Global attributes, a named slot with attributes, and a slot argument

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
  attr :rest, :global, include: ~w(data-note)

  slot :stamp do
    attr :label, :string, required: true
  end

  def telemetry_tag(assigns) do
    ~H"""
    <article id={@id} class="scenario" {@rest}>
      <h2>Brant {@code}</h2>
      <p id={"#{@id}-note"}>
        {printable_note(@raw_note?, @note)}
      </p>
      <p id={"#{@id}-glyph"}>{@glyph}</p>
      <footer :for={stamp <- @stamp}>
        <span>{stamp.label}</span> {render_slot(stamp, @code)}
      </footer>
    </article>
    """
  end

  defp printable_note(true, note), do: raw(note)
  defp printable_note(false, note), do: note

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
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
        data-note={@note}
      >
        <:stamp :let={code} label="Range stamp">
          <span id="range-stamp-code">{code}</span>
        </:stamp>
      </.telemetry_tag>
    </Layouts.app>
    """
  end
end
