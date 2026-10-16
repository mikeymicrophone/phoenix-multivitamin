# Verified routes · 05 · Funchal wind card
#
# Teaches:
# - A controller redirect(to: ~p"...") lands on this LiveView
# - handle_params/3 reads the query the controller verified
# - The drift calculator is a get route; the card is the live route

defmodule PhoenixMultivitaminWeb.FunchalWindCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.FunchalWindCardController

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Funchal wind card")
     |> assign(:station, "Funchal wind card")
     |> assign(:atco, "Rui")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    set = Map.get(params, "set", "head")
    knots = Map.get(params, "knots", "12")

    {:noreply,
     socket
     |> assign(:set, set)
     |> assign(:knots, knots)
     |> assign(:card_path, card_path())
     |> assign(:drift_path, FunchalWindCardController.drift_path())}
  end

  def card_path, do: ~p"/features/02-verified-routes/05-funchal-wind-card"

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 05 · Funchal wind card
      </p>

      <h1>Funchal wind card</h1>
      <p class="lede">
        ATCO {@atco} posts the wind off {@station} for the Airbus A330.
        The drift calculator is a controller action that redirects with ~p.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>ATCO</dt>
        <dd id="atco-name">{@atco}</dd>
        <dt>Set</dt>
        <dd id="wind-set">{@set}</dd>
        <dt>Knots</dt>
        <dd id="wind-knots">{@knots}</dd>
        <dt>Card path</dt>
        <dd id="card-path">{@card_path}</dd>
        <dt>Drift calculator</dt>
        <dd id="drift-path">{@drift_path}</dd>
      </dl>

      <div class="watch-actions">
        <.link id="run-drift" href={@drift_path}>Run drift calculator</.link>
      </div>

      <div class="scenario">
        <h2>Wind</h2>
        <p id="wind-copy">
          {@set} at {@knots} kn, logged from the Funchal threshold.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
