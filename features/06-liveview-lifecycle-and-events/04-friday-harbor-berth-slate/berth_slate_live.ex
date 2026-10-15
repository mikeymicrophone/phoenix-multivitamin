# LiveView lifecycle and events · 04 · Friday Harbor berth slate
#
# Teaches:
# - phx-change validates as the harbormaster types, without posting the berth
# - phx-submit posts the assignment and is a different event name
# - Submit params do not include "_target"
# - A type="submit" button inside the form fires phx-submit, not a click

defmodule PhoenixMultivitaminWeb.FridayHarborBerthSlateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @slips ~w(A-12 B-3 Customs-dock)

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Friday Harbor berth slate")
     |> assign(:harbor, "Friday Harbor")
     |> assign(:harbormaster, "Nell")
     |> assign(:vessel, "")
     |> assign(:slip, "A-12")
     |> assign(:preview, nil)
     |> assign(:error, nil)
     |> assign(:last_event, nil)
     |> assign(:had_target?, false)
     |> assign(:posted_berths, [])}
  end

  @impl true
  def handle_event("preview_berth", params, socket) do
    %{"slate" => %{"vessel" => vessel, "slip" => slip}} = params
    error = berth_error(vessel, slip, socket.assigns.posted_berths)

    {:noreply,
     socket
     |> assign(:vessel, vessel)
     |> assign(:slip, slip)
     |> assign(:error, error)
     |> assign(:preview, preview_line(vessel, slip, error))
     |> assign(:last_event, "preview_berth")
     |> assign(:had_target?, Map.has_key?(params, "_target"))}
  end

  def handle_event("assign_berth", params, socket) do
    %{"slate" => %{"vessel" => vessel, "slip" => slip}} = params
    error = berth_error(vessel, slip, socket.assigns.posted_berths)

    socket =
      socket
      |> assign(:vessel, vessel)
      |> assign(:slip, slip)
      |> assign(:last_event, "assign_berth")
      |> assign(:had_target?, Map.has_key?(params, "_target"))

    if error do
      {:noreply,
       assign(socket, :error, error) |> assign(:preview, preview_line(vessel, slip, error))}
    else
      berth = %{
        id: "berth-#{System.unique_integer([:positive])}",
        vessel: vessel,
        slip: slip
      }

      {:noreply,
       socket
       |> assign(:error, nil)
       |> assign(:preview, nil)
       |> assign(:vessel, "")
       |> assign(:posted_berths, [berth | socket.assigns.posted_berths])}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 04 · Friday Harbor berth slate
      </p>

      <h1>Friday Harbor berth slate</h1>
      <p class="lede">
        Harbormaster {@harbormaster} assigns packets, fish buyers, and the
        county float at {@harbor}. <code>phx-change</code>
        previews the berth. <code>phx-submit</code>
        posts it. Submit does not send <code>_target</code>.
      </p>

      <dl class="station-meta">
        <dt>Harbor</dt>
        <dd id="harbor-name">{@harbor}</dd>
        <dt>Harbormaster</dt>
        <dd id="harbormaster-name">{@harbormaster}</dd>
        <dt>Last event</dt>
        <dd id="last-event">{@last_event || "none"}</dd>
        <dt>Had _target</dt>
        <dd id="had-target">{if @had_target?, do: "yes", else: "no"}</dd>
        <dt>Preview</dt>
        <dd id="berth-preview">{@preview || "none"}</dd>
      </dl>

      <form id="berth-slate-form" phx-change="preview_berth" phx-submit="assign_berth">
        <label>
          Vessel
          <input
            id="vessel-name"
            type="text"
            name="slate[vessel]"
            value={@vessel}
            placeholder="M/V Kirkland"
          />
        </label>
        <label>
          Slip
          <select id="slip-select" name="slate[slip]">
            <option :for={slip <- slips()} value={slip} selected={slip == @slip}>{slip}</option>
          </select>
        </label>
        <p :if={@error} id="berth-error">{@error}</p>
        <div class="watch-actions">
          <button id="post-berth" type="submit">Post berth</button>
        </div>
      </form>

      <div class="scenario">
        <h2>Posted slate</h2>
        <p :if={@posted_berths == []} id="empty-slate" class="muted">
          No berths posted this tide.
        </p>
        <ol id="posted-berths" class="watch-log">
          <li :for={berth <- @posted_berths} id={berth.id}>
            {berth.vessel} at {berth.slip}
          </li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp slips, do: @slips

  defp berth_error(vessel, slip, posted) do
    cond do
      String.trim(vessel) == "" ->
        "Name the vessel before posting"

      String.length(String.trim(vessel)) < 3 ->
        "Vessel name is too short for the slate"

      Enum.any?(posted, &(&1.slip == slip)) ->
        "#{slip} already holds #{Enum.find(posted, &(&1.slip == slip)).vessel}"

      true ->
        nil
    end
  end

  defp preview_line(_vessel, _slip, error) when is_binary(error), do: error
  defp preview_line(vessel, slip, _error), do: "#{vessel} standing by for #{slip}"
end
