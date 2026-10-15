# Verified routes · 05 · West Point current card
#
# Teaches:
# - A controller redirect(to: ~p"...") lands on this LiveView
# - handle_params/3 reads the query the controller verified
# - The drift calculator is a get route; the card is the live route

defmodule PhoenixMultivitaminWeb.WestPointCurrentCardLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.WestPointCurrentCardController

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "West Point current card")
     |> assign(:station, "West Point Light")
     |> assign(:keeper, "Ivo")}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    set = Map.get(params, "set", "flood")
    knots = Map.get(params, "knots", "0.8")

    {:noreply,
     socket
     |> assign(:set, set)
     |> assign(:knots, knots)
     |> assign(:card_path, card_path())
     |> assign(:drift_path, WestPointCurrentCardController.drift_path())}
  end

  def card_path, do: ~p"/features/02-verified-routes/05-west-point-current-card"

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 05 · West Point current card
      </p>

      <h1>West Point current card</h1>
      <p class="lede">
        Keeper {@keeper} posts the current off {@station} at Discovery Park.
        The drift calculator is a controller action that redirects with ~p.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Keeper</dt>
        <dd id="keeper-name">{@keeper}</dd>
        <dt>Set</dt>
        <dd id="current-set">{@set}</dd>
        <dt>Knots</dt>
        <dd id="current-knots">{@knots}</dd>
        <dt>Card path</dt>
        <dd id="card-path">{@card_path}</dd>
        <dt>Drift calculator</dt>
        <dd id="drift-path">{@drift_path}</dd>
      </dl>

      <div class="watch-actions">
        <.link id="run-drift" href={@drift_path}>Run drift calculator</.link>
      </div>

      <div class="scenario">
        <h2>Current</h2>
        <p id="current-copy">
          {@set} at {@knots} kn, logged from the West Point dolphin.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
