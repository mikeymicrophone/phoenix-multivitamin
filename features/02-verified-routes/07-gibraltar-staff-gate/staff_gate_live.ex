# Verified routes · 07 · Gibraltar staff gate
#
# Teaches:
# - An empty query map or keyword list omits the ? entirely
# - nil values encode as an empty value (crew=), they are not dropped
# - false still encodes as "false"; it is not omitted
# - Leave a key out of the keyword list to omit it; do not pass nil

defmodule PhoenixMultivitaminWeb.GibraltarStaffGateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Gibraltar staff gate")
     |> assign(:station, "Gibraltar staff gate")
     |> assign(:guard, "Amira")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    crew = Map.get(params, "crew")
    qnh = Map.get(params, "qnh")
    relief? = Map.get(params, "relief")

    {:noreply,
     socket
     |> assign(:crew, crew)
     |> assign(:qnh, qnh)
     |> assign(:relief?, relief?)
     |> assign(:bare_path, gate_path([]))
     |> assign(:crew_path, gate_path(crew: "relief van"))
     |> assign(:omitted_path, gate_path(crew: nil, qnh: "1013"))
     |> assign(:false_path, gate_path(relief: false))
     |> assign(:both_path, gate_path(crew: "Amira", qnh: "1020"))}
  end

  def gate_path, do: ~p"/features/02-verified-routes/07-gibraltar-staff-gate"

  def gate_path(query) when is_list(query) or is_map(query) do
    ~p"/features/02-verified-routes/07-gibraltar-staff-gate?#{query}"
  end

  @impl true
  def handle_event("open_bare", _params, socket) do
    {:noreply, push_patch(socket, to: gate_path([]))}
  end

  def handle_event("admit_relief_van", _params, socket) do
    {:noreply, push_patch(socket, to: gate_path(crew: "relief van"))}
  end

  def handle_event("log_qnh_without_crew", _params, socket) do
    {:noreply, push_patch(socket, to: gate_path(crew: nil, qnh: "1013"))}
  end

  def handle_event("mark_no_relief", _params, socket) do
    {:noreply, push_patch(socket, to: gate_path(relief: false))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 07 · Gibraltar staff gate
      </p>

      <h1>Gibraltar staff gate</h1>
      <p class="lede">
        Guard {@guard} works the staff gate at {@station} on the
        North Front. An empty query drops the ?. A nil crew becomes crew=.
        Leave the key out to omit it. A false relief flag stays on the URL.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Guard</dt>
        <dd id="guard-name">{@guard}</dd>
        <dt>Crew</dt>
        <dd id="gate-crew">{blank_to_none(@crew)}</dd>
        <dt>QNH</dt>
        <dd id="gate-qnh">{blank_to_unposted(@qnh)}</dd>
        <dt>Relief flag</dt>
        <dd id="gate-relief">{@relief? || "omitted"}</dd>
        <dt>Bare gate</dt>
        <dd id="bare-gate-path">{@bare_path}</dd>
        <dt>Crew query</dt>
        <dd id="crew-gate-path">{@crew_path}</dd>
        <dt>Nil crew, QNH</dt>
        <dd id="nil-crew-gate-path">{@omitted_path}</dd>
        <dt>QNH only</dt>
        <dd id="qnh-only-gate-path">{gate_path(qnh: "1013")}</dd>
        <dt>Relief false</dt>
        <dd id="false-gate-path">{@false_path}</dd>
        <dt>Crew and QNH</dt>
        <dd id="both-gate-path">{@both_path}</dd>
      </dl>

      <div class="watch-actions">
        <button id="open-bare" type="button" phx-click="open_bare">Open bare gate</button>
        <button id="admit-relief-van" type="button" phx-click="admit_relief_van">
          Admit relief van
        </button>
        <button id="log-qnh" type="button" phx-click="log_qnh_without_crew">Log QNH</button>
        <button id="mark-no-relief" type="button" phx-click="mark_no_relief">No relief</button>
      </div>

      <div class="scenario">
        <h2>Gate</h2>
        <p id="gate-copy">
          Staff gate at Gibraltar. Crew {blank_to_none(@crew)}, QNH {blank_to_unposted(@qnh)}.
        </p>
      </div>
    </Layouts.catalog>
    """
  end

  defp blank_to_none(value) when value in [nil, ""], do: "none"
  defp blank_to_none(value), do: value

  defp blank_to_unposted(value) when value in [nil, ""], do: "unposted"
  defp blank_to_unposted(value), do: value
end
