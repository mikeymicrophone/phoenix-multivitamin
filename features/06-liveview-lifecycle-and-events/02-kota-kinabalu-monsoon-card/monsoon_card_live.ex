# LiveView lifecycle and events · 02 · Kota Kinabalu monsoon card
#
# Teaches:
# - phx-click with phx-value-* puts those attributes into the event map
# - Every phx-value-* arrives as a string, even when it looks like a number
# - A click with no phx-value-* still fires handle_event/3 with an empty map
# - Hyphenated phx-value names keep the hyphen in the payload key

defmodule PhoenixMultivitaminWeb.KotaKinabaluMonsoonCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Kota Kinabalu monsoon card")
     |> assign(:station, "Kota Kinabalu International")
     |> assign(:controller, "Farah")
     |> assign(:posted_mode, nil)
     |> assign(:posted_values, %{})
     |> assign(:card_lines, [])}
  end

  @impl true
  def handle_event("post_mode", params, socket) do
    mode = Map.get(params, "mode", "clear")
    period = Map.get(params, "period")
    cells = Map.get(params, "cells")
    apparatus = Map.get(params, "apparatus", "weather radar")

    line =
      case mode do
        "two-cells" ->
          "Two cells on the #{apparatus}, #{period}s apart"

        "one-cell" ->
          "One cell on the #{apparatus} every #{period}s"

        "clear" ->
          "Monsoon card cleared, visibility open to the South China Sea"

        _ ->
          "Unlisted mode, card left as posted"
      end

    {:noreply,
     socket
     |> assign(:posted_mode, mode)
     |> assign(:posted_values, %{
       mode: mode,
       period: period,
       cells: cells,
       apparatus: apparatus,
       period_is_binary: is_binary(period),
       cells_is_binary: is_binary(cells)
     })
     |> prepend_line(line)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 02 · Kota Kinabalu monsoon card
      </p>

      <h1>Kota Kinabalu monsoon card</h1>
      <p class="lede">
        ATCO {@controller} posts the monsoon mode at {@station}, looking out
        over the ATR 72 stands. Each button sends the mode on
        <code phx-no-curly-interpolation>phx-value-*</code>
        attributes. The period looks like a number. It arrives as a string.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Controller</dt>
        <dd id="controller-name">{@controller}</dd>
        <dt>Posted mode</dt>
        <dd id="posted-mode">{@posted_mode || "none"}</dd>
        <dt>Period payload</dt>
        <dd id="period-payload">{@posted_values[:period] || "—"}</dd>
        <dt>Period is binary</dt>
        <dd id="period-is-binary">{yes_no(@posted_values[:period_is_binary])}</dd>
        <dt>Cells payload</dt>
        <dd id="cells-payload">{@posted_values[:cells] || "—"}</dd>
        <dt>Cells is binary</dt>
        <dd id="cells-is-binary">{yes_no(@posted_values[:cells_is_binary])}</dd>
      </dl>

      <div class="watch-actions">
        <button
          id="two-cells"
          type="button"
          phx-click="post_mode"
          phx-value-mode="two-cells"
          phx-value-period="15"
          phx-value-cells="2"
          phx-value-apparatus="weather radar"
        >
          Two cells / 15s
        </button>
        <button
          id="one-cell"
          type="button"
          phx-click="post_mode"
          phx-value-mode="one-cell"
          phx-value-period="10"
          phx-value-cells="1"
          phx-value-apparatus="weather radar"
        >
          One cell / 10s
        </button>
        <button id="clear-mode" type="button" phx-click="post_mode">
          Clear the card
        </button>
      </div>

      <div class="scenario">
        <h2>Posted card</h2>
        <p :if={@card_lines == []} id="empty-card" class="muted">
          No mode posted this watch.
        </p>
        <ol id="card-lines" class="watch-log">
          <li :for={line <- @card_lines} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp yes_no(true), do: "yes"
  defp yes_no(_), do: "no"

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :card_lines, [line | socket.assigns.card_lines])
  end
end
