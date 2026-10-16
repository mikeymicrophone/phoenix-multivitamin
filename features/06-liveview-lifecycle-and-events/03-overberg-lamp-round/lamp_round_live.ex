# LiveView lifecycle and events · 03 · Overberg lamp round
#
# Teaches:
# - phx-change on a form sends every field plus "_target" for the input that moved
# - handle_event/3 can switch on "_target" to log which lamp was touched
# - Changing one select does not require a submit
# - The disconnected mount still renders the empty round sheet

defmodule PhoenixMultivitaminWeb.OverbergLampRoundLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Overberg lamp round")
     |> assign(:station, "Overberg Test Range")
     |> assign(:lampie, "Piet")
     |> assign(:round, %{
       "runway_papi" => "uninspected",
       "threshold_bar" => "uninspected",
       "tower_beacon" => "uninspected"
     })
     |> assign(:last_target, nil)
     |> assign(:round_lines, [])}
  end

  @impl true
  def handle_event("record_lamp", %{"_target" => ["round", field]} = params, socket) do
    value = get_in(params, ["round", field]) || "uninspected"
    round = Map.put(socket.assigns.round, field, value)

    {:noreply,
     socket
     |> assign(:round, round)
     |> assign(:last_target, field)
     |> prepend_line("#{label(field)} set to #{value}")}
  end

  def handle_event("record_lamp", params, socket) do
    round = Map.merge(socket.assigns.round, Map.get(params, "round", %{}))

    {:noreply, assign(socket, :round, round)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 03 · Overberg lamp round
      </p>

      <h1>Overberg lamp round</h1>
      <p class="lede">
        Lampie {@lampie} walks the lamp round at {@station}, before the Atlas
        Cheetah rolls. Each select posts on <code>phx-change</code>. The event
        map includes <code>_target</code>, so the sheet knows which lamp moved.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Lampie</dt>
        <dd id="lampie-name">{@lampie}</dd>
        <dt>Last target</dt>
        <dd id="last-target">{@last_target || "none"}</dd>
        <dt>Runway PAPI</dt>
        <dd id="papi-state">{@round["runway_papi"]}</dd>
        <dt>Threshold bar</dt>
        <dd id="threshold-state">{@round["threshold_bar"]}</dd>
        <dt>Tower beacon</dt>
        <dd id="beacon-state">{@round["tower_beacon"]}</dd>
      </dl>

      <form id="lamp-round-form" phx-change="record_lamp" class="scenario">
        <h2>Round sheet</h2>
        <label>
          Runway PAPI
          <select id="runway-papi" name="round[runway_papi]">
            <option value="uninspected">uninspected</option>
            <option value="trimmed">trimmed</option>
            <option value="sooted">sooted</option>
            <option value="lit">lit</option>
          </select>
        </label>
        <label>
          Threshold bar
          <select id="threshold-bar" name="round[threshold_bar]">
            <option value="uninspected">uninspected</option>
            <option value="cold">cold</option>
            <option value="banked">banked</option>
            <option value="up-to-pressure">up to pressure</option>
          </select>
        </label>
        <label>
          Tower beacon
          <select id="tower-beacon" name="round[tower_beacon]">
            <option value="uninspected">uninspected</option>
            <option value="out">out</option>
            <option value="embers">embers</option>
            <option value="drawing">drawing</option>
          </select>
        </label>
      </form>

      <div class="scenario">
        <h2>Posted touches</h2>
        <p :if={@round_lines == []} id="empty-round" class="muted">
          No lamp touched this round.
        </p>
        <ol id="round-lines" class="watch-log">
          <li :for={line <- @round_lines} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp label("runway_papi"), do: "Runway PAPI"
  defp label("threshold_bar"), do: "Threshold bar"
  defp label("tower_beacon"), do: "Tower beacon"
  defp label(other), do: other

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :round_lines, [line | socket.assigns.round_lines])
  end
end
