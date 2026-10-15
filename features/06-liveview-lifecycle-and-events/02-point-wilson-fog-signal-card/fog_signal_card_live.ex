# LiveView lifecycle and events · 02 · Point Wilson fog signal card
#
# Teaches:
# - phx-click with phx-value-* puts those attributes into the event map
# - Every phx-value-* arrives as a string, even when it looks like a number
# - A click with no phx-value-* still fires handle_event/3 with an empty map
# - Hyphenated phx-value names keep the hyphen in the payload key

defmodule PhoenixMultivitaminWeb.PointWilsonFogSignalCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Point Wilson fog signal card")
     |> assign(:station, "Point Wilson Light")
     |> assign(:keeper, "Evander")
     |> assign(:posted_characteristic, nil)
     |> assign(:posted_values, %{})
     |> assign(:card_lines, [])}
  end

  @impl true
  def handle_event("post_characteristic", params, socket) do
    characteristic = Map.get(params, "characteristic", "silence")
    period = Map.get(params, "period")
    blasts = Map.get(params, "blasts")
    apparatus = Map.get(params, "apparatus", "diaphone")

    line =
      case characteristic do
        "two-blasts" ->
          "Two blasts on the #{apparatus}, #{period}s apart"

        "one-blast" ->
          "One blast on the #{apparatus} every #{period}s"

        "silence" ->
          "Fog signal silenced, visibility clear to Admiralty Inlet"

        _ ->
          "Unlisted characteristic, card left as posted"
      end

    {:noreply,
     socket
     |> assign(:posted_characteristic, characteristic)
     |> assign(:posted_values, %{
       characteristic: characteristic,
       period: period,
       blasts: blasts,
       apparatus: apparatus,
       period_is_binary: is_binary(period),
       blasts_is_binary: is_binary(blasts)
     })
     |> prepend_line(line)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 02 · Point Wilson fog signal card
      </p>

      <h1>Point Wilson fog signal card</h1>
      <p class="lede">
        Keeper {@keeper} posts the fog signal at {@station}, on the spit north
        of Port Townsend. Each button sends the characteristic on
        <code phx-no-curly-interpolation>phx-value-*</code>
        attributes. The period looks like a number. It arrives as a string.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Posted characteristic</dt>
        <dd id="posted-characteristic">{@posted_characteristic || "none"}</dd>
        <dt>Period payload</dt>
        <dd id="period-payload">{@posted_values[:period] || "—"}</dd>
        <dt>Period is binary</dt>
        <dd id="period-is-binary">{yes_no(@posted_values[:period_is_binary])}</dd>
        <dt>Blasts payload</dt>
        <dd id="blasts-payload">{@posted_values[:blasts] || "—"}</dd>
        <dt>Blasts is binary</dt>
        <dd id="blasts-is-binary">{yes_no(@posted_values[:blasts_is_binary])}</dd>
      </dl>

      <div class="watch-actions">
        <button
          id="two-blasts"
          type="button"
          phx-click="post_characteristic"
          phx-value-characteristic="two-blasts"
          phx-value-period="15"
          phx-value-blasts="2"
          phx-value-apparatus="diaphone"
        >
          Two blasts / 15s
        </button>
        <button
          id="one-blast"
          type="button"
          phx-click="post_characteristic"
          phx-value-characteristic="one-blast"
          phx-value-period="10"
          phx-value-blasts="1"
          phx-value-apparatus="diaphone"
        >
          One blast / 10s
        </button>
        <button id="silence-signal" type="button" phx-click="post_characteristic">
          Silence the signal
        </button>
      </div>

      <div class="scenario">
        <h2>Posted card</h2>
        <p :if={@card_lines == []} id="empty-card" class="muted">
          No characteristic posted this watch.
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
