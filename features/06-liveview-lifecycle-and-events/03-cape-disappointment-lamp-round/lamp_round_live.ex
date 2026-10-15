# LiveView lifecycle and events · 03 · Cape Disappointment lamp round
#
# Teaches:
# - phx-change on a form sends every field plus "_target" for the input that moved
# - handle_event/3 can switch on "_target" to log which lamp was touched
# - Changing one select does not require a submit
# - The disconnected mount still renders the empty round sheet

defmodule PhoenixMultivitaminWeb.CapeDisappointmentLampRoundLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Cape Disappointment lamp round")
     |> assign(:station, "Cape Disappointment Light")
     |> assign(:keeper, "Sigrid")
     |> assign(:round, %{
       "first_order_lens" => "uninspected",
       "steam_siren" => "uninspected",
       "watch_room_stove" => "uninspected"
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
        · 03 · Cape Disappointment lamp round
      </p>

      <h1>Cape Disappointment lamp round</h1>
      <p class="lede">
        Keeper {@keeper} walks the lamp round at {@station}, at the mouth of
        the Columbia. Each select posts on <code>phx-change</code>. The event
        map includes <code>_target</code>, so the sheet knows which lamp moved.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Last target</dt>
        <dd id="last-target">{@last_target || "none"}</dd>
        <dt>First-order lens</dt>
        <dd id="lens-state">{@round["first_order_lens"]}</dd>
        <dt>Steam siren</dt>
        <dd id="siren-state">{@round["steam_siren"]}</dd>
        <dt>Watch-room stove</dt>
        <dd id="stove-state">{@round["watch_room_stove"]}</dd>
      </dl>

      <form id="lamp-round-form" phx-change="record_lamp" class="scenario">
        <h2>Round sheet</h2>
        <label>
          First-order lens
          <select id="first-order-lens" name="round[first_order_lens]">
            <option value="uninspected">uninspected</option>
            <option value="trimmed">trimmed</option>
            <option value="sooted">sooted</option>
            <option value="lit">lit</option>
          </select>
        </label>
        <label>
          Steam siren
          <select id="steam-siren" name="round[steam_siren]">
            <option value="uninspected">uninspected</option>
            <option value="cold">cold</option>
            <option value="banked">banked</option>
            <option value="up-to-pressure">up to pressure</option>
          </select>
        </label>
        <label>
          Watch-room stove
          <select id="watch-room-stove" name="round[watch_room_stove]">
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

  defp label("first_order_lens"), do: "First-order lens"
  defp label("steam_siren"), do: "Steam siren"
  defp label("watch_room_stove"), do: "Watch-room stove"
  defp label(other), do: other

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :round_lines, [line | socket.assigns.round_lines])
  end
end
