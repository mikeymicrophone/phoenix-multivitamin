# LiveView lifecycle and events · 05 · Gifu autoclave card
#
# Teaches:
# - phx-blur fires when the field loses focus, not on every keystroke
# - The blur payload is that field's phx-value-* plus the value you pass
# - Blur is not a form change: it does not send the rest of the cure card
# - A later blur can complete a cure that an earlier blur started

defmodule PhoenixMultivitaminWeb.GifuAutoclaveCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Gifu autoclave card")
     |> assign(:works, "Kawasaki Gifu Works")
     |> assign(:tech, "Yuto")
     |> assign(:autoclave, "Autoclave 3")
     |> assign(:layup, "C-2 spar carbon ply")
     |> assign(:temperature_f, nil)
     |> assign(:cure_minutes, nil)
     |> assign(:vent_closed?, false)
     |> assign(:last_blur, nil)
     |> assign(:card_lines, [])}
  end

  @impl true
  def handle_event("record_temperature", params, socket) do
    raw = Map.get(params, "value") || Map.get(params, "temperature")

    temperature =
      case Integer.parse(to_string(raw || "")) do
        {n, _} -> n
        :error -> 0
      end

    line =
      cond do
        temperature >= 242 ->
          "#{temperature}°F in #{socket.assigns.autoclave}, at process for #{socket.assigns.layup}"

        temperature > 0 ->
          "#{temperature}°F in #{socket.assigns.autoclave}, still coming up"

        true ->
          "Temperature left blank on the cure card"
      end

    {:noreply,
     socket
     |> assign(:temperature_f, temperature)
     |> assign(:last_blur, "temperature")
     |> prepend_line(line)}
  end

  def handle_event("record_cure_minutes", params, socket) do
    raw = Map.get(params, "value") || Map.get(params, "minutes")

    minutes =
      case Integer.parse(to_string(raw || "")) do
        {n, _} -> n
        :error -> 0
      end

    {:noreply,
     socket
     |> assign(:cure_minutes, minutes)
     |> assign(:last_blur, "cure_minutes")
     |> prepend_line("#{minutes} minute cure marked for #{socket.assigns.layup}")}
  end

  def handle_event("close_vent", _params, socket) do
    {:noreply,
     socket
     |> assign(:vent_closed?, true)
     |> prepend_line("Vent closed on #{socket.assigns.autoclave}")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 05 · Gifu autoclave card
      </p>

      <h1>Gifu autoclave card</h1>
      <p class="lede">
        Tech {@tech} keeps the autoclave card at {@works}. Temperature and
        cure time post on <code>phx-blur</code>, when he leaves the field,
        not on every digit.
      </p>

      <dl class="station-meta">
        <dt>Works</dt>
        <dd id="works-name">{@works}</dd>
        <dt>Tech</dt>
        <dd id="tech-name">{@tech}</dd>
        <dt>Autoclave</dt>
        <dd id="autoclave-name">{@autoclave}</dd>
        <dt>Layup</dt>
        <dd id="layup-name">{@layup}</dd>
        <dt>Temperature</dt>
        <dd id="temperature-f">{@temperature_f || "—"}</dd>
        <dt>Cure minutes</dt>
        <dd id="cure-minutes">{@cure_minutes || "—"}</dd>
        <dt>Vent</dt>
        <dd id="vent-state">{if @vent_closed?, do: "closed", else: "open"}</dd>
        <dt>Last blur</dt>
        <dd id="last-blur">{@last_blur || "none"}</dd>
      </dl>

      <div class="scenario">
        <h2>Cure card</h2>
        <label>
          Temperature °F
          <input
            id="temperature-field"
            type="text"
            name="temperature"
            phx-blur="record_temperature"
            phx-value-autoclave="3"
          />
        </label>
        <label>
          Cure minutes
          <input
            id="cure-minutes-field"
            type="text"
            name="minutes"
            phx-blur="record_cure_minutes"
          />
        </label>
        <div class="watch-actions">
          <button id="close-vent" type="button" phx-click="close_vent">Close the vent</button>
        </div>
      </div>

      <div class="scenario">
        <h2>Posted readings</h2>
        <p :if={@card_lines == []} id="empty-card" class="muted">
          No readings posted this cure.
        </p>
        <ol id="card-lines" class="watch-log">
          <li :for={line <- @card_lines} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :card_lines, [line | socket.assigns.card_lines])
  end
end
