# LiveView lifecycle and events · 06 · Vágar weather round
#
# Teaches:
# - phx-keydown sends the event with a "key" in the payload
# - phx-key is a client-side filter; LiveViewTest does not apply it
# - The server still sees whatever key the client sent
# - Pattern-matching the payload is how the round ignores a stray key

defmodule PhoenixMultivitaminWeb.VagarWeatherRoundLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Vágar weather round")
     |> assign(:station, "Vágar Airport")
     |> assign(:observer, "Jóhanna")
     |> assign(:last_key, nil)
     |> assign(:last_binding, nil)
     |> assign(:observations, [])}
  end

  @impl true
  def handle_event("note_wind", %{"key" => key}, socket) do
    if String.downcase(to_string(key)) == "w" do
      {:noreply, note(socket, key, "wind", "West-northwest 28 knots off Sørvágsvatn")}
    else
      {:noreply, stray(socket, key, "note_wind")}
    end
  end

  def handle_event("note_fog", %{"key" => key}, socket) do
    if String.downcase(to_string(key)) == "f" do
      {:noreply, note(socket, key, "fog", "Low cloud stacking over the ridge, visibility 400 m")}
    else
      {:noreply, stray(socket, key, "note_fog")}
    end
  end

  def handle_event("post_round", %{"key" => key}, socket) do
    if to_string(key) in ["Enter", "enter"] do
      {:noreply, note(socket, key, "enter", "Weather round posted to the Vágar sheet")}
    else
      {:noreply, stray(socket, key, "post_round")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 06 · Vágar weather round
      </p>

      <h1>Vágar weather round</h1>
      <p class="lede">
        Observer {@observer} logs the weather at {@station}, before the Airbus
        A320 departs. <code>phx-key</code> keeps the browser from sending the wrong key.
        LiveViewTest does not honor that filter, so a stray key still arrives.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Observer</dt>
        <dd id="observer-name">{@observer}</dd>
        <dt>Last key</dt>
        <dd id="last-key">{@last_key || "none"}</dd>
        <dt>Last binding</dt>
        <dd id="last-binding">{@last_binding || "none"}</dd>
      </dl>

      <div class="scenario">
        <h2>Key desk</h2>
        <p>
          Focus a pad and press the labeled key. The browser sends only that
          key. Tests can send any key they like.
        </p>
        <div class="watch-actions">
          <div id="wind-pad" tabindex="0" phx-keydown="note_wind" phx-key="w">
            W · wind
          </div>
          <div id="fog-pad" tabindex="0" phx-keydown="note_fog" phx-key="f">
            F · fog
          </div>
          <div id="enter-pad" tabindex="0" phx-keydown="post_round" phx-key="Enter">
            Enter · post the round
          </div>
        </div>
      </div>

      <div class="scenario">
        <h2>Posted observations</h2>
        <p :if={@observations == []} id="empty-round" class="muted">
          No observations this round.
        </p>
        <ol id="observations" class="watch-log">
          <li :for={line <- @observations} id={line.id}>{line.body}</li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp note(socket, key, binding, body) do
    socket
    |> assign(:last_key, key)
    |> assign(:last_binding, binding)
    |> prepend_line(body)
  end

  defp stray(socket, key, event) do
    socket
    |> assign(:last_key, key)
    |> assign(:last_binding, event)
    |> prepend_line("Stray key #{inspect(key)} reached #{event} without a client filter")
  end

  defp prepend_line(socket, body) do
    line = %{id: "line-#{System.unique_integer([:positive])}", body: body}
    assign(socket, :observations, [line | socket.assigns.observations])
  end
end
