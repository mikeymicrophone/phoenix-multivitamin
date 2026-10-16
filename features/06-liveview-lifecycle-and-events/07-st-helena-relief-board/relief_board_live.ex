# LiveView lifecycle and events · 07 · St Helena relief board
#
# Teaches:
# - phx-debounce="500" is a client-side delay on phx-change
# - phx-debounce="blur" waits for focus loss instead of a timer
# - LiveViewTest's render_change/2 fires immediately; it does not wait
# - The markup still carries the debounce attribute for the browser

defmodule PhoenixMultivitaminWeb.StHelenaReliefBoardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "St Helena relief board")
     |> assign(:station, "St Helena Airport")
     |> assign(:clerk, "Percy")
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
        · 07 · St Helena relief board
      </p>

      <h1>St Helena relief board</h1>
      <p class="lede">
        Clerk {@clerk} copies the relief Airbus A330-200 at {@station}. The
        radio copy field debounces 500ms. The landing field waits for blur.
        LiveViewTest posts both immediately.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
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
            placeholder="SAH 330 departing Johannesburg with stores"
          />
        </label>
      </form>

      <form id="landing-form" phx-change="draft_landing" class="scenario">
        <h2>Landing note</h2>
        <label>
          Runway note
          <input
            id="landing-field"
            type="text"
            name="relief[landing]"
            value={@landing_note}
            phx-debounce="blur"
            placeholder="Crosswind too high on 20"
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
