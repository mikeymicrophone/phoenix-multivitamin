# LiveView lifecycle and events · 08 · Keflavik jet-stream table
#
# Teaches:
# - phx-throttle="2000" rate-limits repeated clicks in the browser
# - LiveViewTest's render_click/1 does not throttle; every click counts
# - handle_params/3 picks the station reach from the URL
# - The throttle attribute stays in the markup for the real jet-stream table

defmodule PhoenixMultivitaminWeb.KeflavikJetstreamTableLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @reaches %{
    "polar" => %{name: "Polar reach", core: "westerly core", observer: "Birkir"},
    "atlantic" => %{name: "Atlantic reach", core: "shear along the coast", observer: "Birkir"}
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Keflavik jet-stream table")
     |> assign(:station, "Keflavik")
     |> assign(:knots, 0)
     |> assign(:click_count, 0)
     |> assign(:table_lines, [])}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    reach_key = Map.get(params, "reach", "polar")
    reach = Map.get(@reaches, reach_key, @reaches["polar"])

    {:noreply,
     socket
     |> assign(:reach_key, reach_key)
     |> assign(:reach, reach)}
  end

  @impl true
  def handle_event("log_knot", %{"delta" => delta}, socket) do
    {delta, _} = Integer.parse(delta)
    knots = max(socket.assigns.knots + delta, 0)

    {:noreply,
     socket
     |> assign(:knots, knots)
     |> assign(:click_count, socket.assigns.click_count + 1)
     |> prepend_line("#{knots} kn on the #{socket.assigns.reach.name}")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 08 · Keflavik jet-stream table
      </p>

      <h1>Keflavik jet-stream table</h1>
      <p class="lede">
        Observer {@reach.observer} logs the jet stream at {@station}, for the
        Boeing 757 tracks. The knot buttons throttle in the browser. LiveViewTest
        counts every click.
      </p>

      <div class="watch-switcher">
        <.link
          id="polar-reach"
          patch={
            ~p"/features/06-liveview-lifecycle-and-events/08-keflavik-jetstream-table?#{[reach: "polar"]}"
          }
        >
          Polar reach
        </.link>
        <.link
          id="atlantic-reach"
          patch={
            ~p"/features/06-liveview-lifecycle-and-events/08-keflavik-jetstream-table?#{[reach: "atlantic"]}"
          }
        >
          Atlantic reach
        </.link>
      </div>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Reach</dt>
        <dd id="reach-name">{@reach.name}</dd>
        <dt>Core</dt>
        <dd id="core-set">{@reach.core}</dd>
        <dt>Knots</dt>
        <dd id="knot-count">{@knots}</dd>
        <dt>Clicks counted</dt>
        <dd id="click-count">{@click_count}</dd>
      </dl>

      <div class="watch-actions">
        <button
          id="plus-knot"
          type="button"
          phx-click="log_knot"
          phx-value-delta="1"
          phx-throttle="2000"
        >
          +1 kn
        </button>
        <button
          id="minus-knot"
          type="button"
          phx-click="log_knot"
          phx-value-delta="-1"
          phx-throttle="2000"
        >
          −1 kn
        </button>
      </div>

      <div class="scenario">
        <h2>Posted stream</h2>
        <p :if={@table_lines == []} id="empty-table" class="muted">
          No core posted this shift.
        </p>
        <ol id="table-lines" class="watch-log">
          <li :for={line <- @table_lines} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :table_lines, [line | socket.assigns.table_lines])
  end
end
