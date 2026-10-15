# LiveView lifecycle and events · 09 · Slip Point bell book
#
# Teaches:
# - send(self(), msg) from handle_event/3 is handled in handle_info/2
# - That handle_info/2 runs after the event's render, as the next mailbox message
# - Process.send_after/3 schedules later strikes only while the bell is running
# - Stopping the bell leaves a late send_after harmless because the flag is false

defmodule PhoenixMultivitaminWeb.SlipPointBellBookLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Slip Point bell book")
     |> assign(:station, "Slip Point Light")
     |> assign(:keeper, "Willa")
     |> assign(:bell_running?, false)
     |> assign(:strikes, 0)
     |> assign(:event_html_strikes, 0)
     |> assign(:book_lines, [])}
  end

  @impl true
  def handle_event("start_watch_bells", _params, socket) do
    send(self(), :strike_bell)

    {:noreply,
     socket
     |> assign(:bell_running?, true)
     |> assign(:event_html_strikes, socket.assigns.strikes)
     |> prepend_line("Watch bells started on the Clallam Bay face")}
  end

  def handle_event("stop_watch_bells", _params, socket) do
    {:noreply,
     socket
     |> assign(:bell_running?, false)
     |> prepend_line("Watch bells stopped after #{socket.assigns.strikes} strikes")}
  end

  @impl true
  def handle_info(:strike_bell, socket) do
    if socket.assigns.bell_running? do
      strikes = socket.assigns.strikes + 1

      Process.send_after(self(), :strike_bell, 60_000)

      {:noreply,
       socket
       |> assign(:strikes, strikes)
       |> prepend_line("Bell struck, tally #{strikes}")}
    else
      {:noreply, prepend_line(socket, "Late strike ignored, bells already quiet")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 09 · Slip Point bell book
      </p>

      <h1>Slip Point bell book</h1>
      <p class="lede">
        Keeper {@keeper} works the fog bell at {@station}, on Clallam Bay.
        Starting the bells does <code>send(self(), :strike_bell)</code>. The
        strike is the next message, after that click has already rendered.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Bells</dt>
        <dd id="bell-state">{if @bell_running?, do: "running", else: "quiet"}</dd>
        <dt>Strikes</dt>
        <dd id="strike-count">{@strikes}</dd>
        <dt>Strikes at event render</dt>
        <dd id="event-html-strikes">{@event_html_strikes}</dd>
      </dl>

      <div class="watch-actions">
        <button id="start-bells" type="button" phx-click="start_watch_bells">
          Start watch bells
        </button>
        <button id="stop-bells" type="button" phx-click="stop_watch_bells">
          Stop watch bells
        </button>
      </div>

      <div class="scenario">
        <h2>Bell book</h2>
        <p :if={@book_lines == []} id="empty-book" class="muted">
          No strikes this watch.
        </p>
        <ol id="book-lines" class="watch-log">
          <li :for={line <- @book_lines} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :book_lines, [line | socket.assigns.book_lines])
  end
end
