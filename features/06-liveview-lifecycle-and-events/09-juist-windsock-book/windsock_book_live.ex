# LiveView lifecycle and events · 09 · Juist windsock book
#
# Teaches:
# - send(self(), msg) from handle_event/3 is handled in handle_info/2
# - That handle_info/2 runs after the event's render, as the next mailbox message
# - Process.send_after/3 schedules later strikes only while the sock is running
# - Stopping the sock leaves a late send_after harmless because the flag is false

defmodule PhoenixMultivitaminWeb.JuistWindsockBookLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Juist windsock book")
     |> assign(:station, "Juist Airfield")
     |> assign(:marshal, "Hilde")
     |> assign(:sock_running?, false)
     |> assign(:strikes, 0)
     |> assign(:event_html_strikes, 0)
     |> assign(:book_lines, [])}
  end

  @impl true
  def handle_event("start_sock_strikes", _params, socket) do
    send(self(), :strike_sock)

    {:noreply,
     socket
     |> assign(:sock_running?, true)
     |> assign(:event_html_strikes, socket.assigns.strikes)
     |> prepend_line("Sock strikes started on the Juist strip")}
  end

  def handle_event("stop_sock_strikes", _params, socket) do
    {:noreply,
     socket
     |> assign(:sock_running?, false)
     |> prepend_line("Sock strikes stopped after #{socket.assigns.strikes} strikes")}
  end

  @impl true
  def handle_info(:strike_sock, socket) do
    if socket.assigns.sock_running? do
      strikes = socket.assigns.strikes + 1

      Process.send_after(self(), :strike_sock, 60_000)

      {:noreply,
       socket
       |> assign(:strikes, strikes)
       |> prepend_line("Sock struck, tally #{strikes}")}
    else
      {:noreply, prepend_line(socket, "Late strike ignored, socks already quiet")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 09 · Juist windsock book
      </p>

      <h1>Juist windsock book</h1>
      <p class="lede">
        Marshal {@marshal} works the windsock at {@station}, before the Twin
        Otter rolls. Starting the socks does <code>send(self(), :strike_sock)</code>. The
        strike is the next message, after that click has already rendered.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Marshal</dt>
        <dd id="marshal-name">{@marshal}</dd>
        <dt>Socks</dt>
        <dd id="sock-state">{if @sock_running?, do: "running", else: "quiet"}</dd>
        <dt>Strikes</dt>
        <dd id="strike-count">{@strikes}</dd>
        <dt>Strikes at event render</dt>
        <dd id="event-html-strikes">{@event_html_strikes}</dd>
      </dl>

      <div class="watch-actions">
        <button id="start-socks" type="button" phx-click="start_sock_strikes">
          Start sock strikes
        </button>
        <button id="stop-socks" type="button" phx-click="stop_sock_strikes">
          Stop sock strikes
        </button>
      </div>

      <div class="scenario">
        <h2>Windsock book</h2>
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
