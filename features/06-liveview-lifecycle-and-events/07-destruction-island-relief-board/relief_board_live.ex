# LiveView lifecycle and events · 07 · Destruction Island relief board
#
# Teaches:
# - phx-debounce="500" is a client-side delay on phx-change
# - phx-debounce="blur" waits for focus loss instead of a timer
# - LiveViewTest's render_change/2 fires immediately; it does not wait
# - The markup still carries the debounce attribute for the browser

defmodule PhoenixMultivitaminWeb.DestructionIslandReliefBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Destruction Island relief board")
     |> assign(:station, "Destruction Island Light")
     |> assign(:operator, "Tove")
     |> assign(:radio_copy, "")
     |> assign(:landing_note, "")
     |> assign(:last_posted_from, nil)
     |> assign(:board_lines, [])}
  end

  @impl true
  def handle_event("draft_radio_copy", %{"relief" => %{"copy" => copy}}, socket) do
    {:noreply,
     socket
     |> assign(:radio_copy, copy)
     |> assign(:last_posted_from, "radio_copy")
     |> prepend_line("Radio: #{copy}")}
  end

  def handle_event("draft_landing", %{"relief" => %{"landing" => landing}}, socket) do
    {:noreply,
     socket
     |> assign(:landing_note, landing)
     |> assign(:last_posted_from, "landing")
     |> prepend_line("Landing: #{landing}")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 07 · Destruction Island relief board
      </p>

      <h1>Destruction Island relief board</h1>
      <p class="lede">
        Radio operator {@operator} copies the relief boat at {@station}, west
        of the Olympic coast. The radio copy field debounces 500ms. The
        landing field waits for blur. LiveViewTest posts both immediately.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Operator</dt>
        <dd id="operator-name">{@operator}</dd>
        <dt>Last posted from</dt>
        <dd id="last-posted-from">{@last_posted_from || "none"}</dd>
        <dt>Radio copy</dt>
        <dd id="radio-copy">{@radio_copy || "—"}</dd>
        <dt>Landing note</dt>
        <dd id="landing-note">{@landing_note || "—"}</dd>
      </dl>

      <form id="radio-copy-form" phx-change="draft_radio_copy" class="scenario">
        <h2>Radio copy</h2>
        <label>
          Incoming relief
          <input
            id="radio-copy-field"
            type="text"
            name="relief[copy]"
            value={@radio_copy}
            phx-debounce="500"
            placeholder="CG 47318 departing La Push with stores"
          />
        </label>
      </form>

      <form id="landing-form" phx-change="draft_landing" class="scenario">
        <h2>Landing note</h2>
        <label>
          Boat landing
          <input
            id="landing-field"
            type="text"
            name="relief[landing]"
            value={@landing_note}
            phx-debounce="blur"
            placeholder="Swell too high on the west face"
          />
        </label>
      </form>

      <div class="scenario">
        <h2>Posted board</h2>
        <p :if={@board_lines == []} id="empty-board" class="muted">
          No relief copy this watch.
        </p>
        <ol id="board-lines" class="watch-log">
          <li :for={line <- @board_lines} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :board_lines, [line | socket.assigns.board_lines])
  end
end
