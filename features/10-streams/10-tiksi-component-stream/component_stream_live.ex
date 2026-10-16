# Streams · 10 · Tiksi component stream
#
# Teaches:
# - A stream of nested LiveComponents

defmodule PhoenixMultivitaminWeb.TiksiComponentStreamLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitaminWeb.TiksiHoistCell

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Tiksi component stream", "Aytal", "Kamov Ka-32")
     |> stream(:hoists, [%{id: "lena", site: "Lena mouth"}])}
  end

  @impl true
  def handle_event("add_laptev", _params, socket) do
    {:noreply, stream_insert(socket, :hoists, %{id: "laptev", site: "Laptev pack"})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Streams · 10 · Tiksi component stream
      </p>

      <h1>Tiksi component stream</h1>
      <p class="lede">
        Clerk {@clerk} streams {@craft} hoist cells at Tiksi.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />

      <button id="add-laptev" type="button" phx-click="add_laptev">
        Add Laptev
      </button>

      <div id="hoists" phx-update="stream">
        <.live_component
          :for={{id, hoist} <- @streams.hoists}
          module={TiksiHoistCell}
          id={id}
          hoist={hoist}
        />
      </div>
    </Layouts.app>
    """
  end
end
