# LiveView lifecycle and events · 05 · Pacific American Cannery retort card
#
# Teaches:
# - phx-blur fires when the field loses focus, not on every keystroke
# - The blur payload is that field's phx-value-* plus the value you pass
# - Blur is not a form change: it does not send the rest of the cook card
# - A later blur can complete a cook that an earlier blur started

defmodule PhoenixMultivitaminWeb.PacificAmericanCanneryRetortCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Pacific American Cannery retort card")
     |> assign(:cannery, "Pacific American Fisheries")
     |> assign(:cook, "Inez")
     |> assign(:retort, "Retort 3")
     |> assign(:pack, "1-pound tall sockeye")
     |> assign(:temperature_f, nil)
     |> assign(:cook_minutes, nil)
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
          "#{temperature}°F in #{socket.assigns.retort}, at process for #{socket.assigns.pack}"

        temperature > 0 ->
          "#{temperature}°F in #{socket.assigns.retort}, still coming up"

        true ->
          "Temperature left blank on the cook card"
      end

    {:noreply,
     socket
     |> assign(:temperature_f, temperature)
     |> assign(:last_blur, "temperature")
     |> prepend_line(line)}
  end

  def handle_event("record_cook_minutes", params, socket) do
    raw = Map.get(params, "value") || Map.get(params, "minutes")

    minutes =
      case Integer.parse(to_string(raw || "")) do
        {n, _} -> n
        :error -> 0
      end

    {:noreply,
     socket
     |> assign(:cook_minutes, minutes)
     |> assign(:last_blur, "cook_minutes")
     |> prepend_line("#{minutes} minute cook marked for #{socket.assigns.pack}")}
  end

  def handle_event("close_vent", _params, socket) do
    {:noreply,
     socket
     |> assign(:vent_closed?, true)
     |> prepend_line("Vent closed on #{socket.assigns.retort}")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 05 · Pacific American Cannery retort card
      </p>

      <h1>Pacific American Cannery retort card</h1>
      <p class="lede">
        Cook {@cook} keeps the retort card at {@cannery} in Bellingham.
        Temperature and cook time post on <code>phx-blur</code>, when she
        leaves the field, not on every digit.
      </p>

      <dl class="station-meta">
        <dt>Cannery</dt>
        <dd id="cannery-name">{@cannery}</dd>
        <dt>Cook</dt>
        <dd id="cook-name">{@cook}</dd>
        <dt>Retort</dt>
        <dd id="retort-name">{@retort}</dd>
        <dt>Pack</dt>
        <dd id="pack-name">{@pack}</dd>
        <dt>Temperature</dt>
        <dd id="temperature-f">{@temperature_f || "—"}</dd>
        <dt>Cook minutes</dt>
        <dd id="cook-minutes">{@cook_minutes || "—"}</dd>
        <dt>Vent</dt>
        <dd id="vent-state">{if @vent_closed?, do: "closed", else: "open"}</dd>
        <dt>Last blur</dt>
        <dd id="last-blur">{@last_blur || "none"}</dd>
      </dl>

      <div class="scenario">
        <h2>Cook card</h2>
        <label>
          Temperature °F
          <input
            id="temperature-field"
            type="text"
            name="temperature"
            phx-blur="record_temperature"
            phx-value-retort="3"
          />
        </label>
        <label>
          Cook minutes
          <input
            id="cook-minutes-field"
            type="text"
            name="minutes"
            phx-blur="record_cook_minutes"
          />
        </label>
        <div class="watch-actions">
          <button id="close-vent" type="button" phx-click="close_vent">Close the vent</button>
        </div>
      </div>

      <div class="scenario">
        <h2>Posted readings</h2>
        <p :if={@card_lines == []} id="empty-card" class="muted">
          No readings posted this cook.
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
