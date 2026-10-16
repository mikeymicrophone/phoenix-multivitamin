# Async assigns · 09 · Kangerlussuaq sounding shelf
#
# Teaches:
# - assign_async reads the Repo without blocking render
# - The dead render is loading; the row arrives after connect

defmodule PhoenixMultivitaminWeb.KangerlussuaqSoundingShelfLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import Ecto.Query

  alias PhoenixMultivitamin.KangerlussuaqSounding
  alias PhoenixMultivitamin.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Kangerlussuaq sounding shelf")
     |> assign(:clerk, "Malik")
     |> assign(:craft, "Airbus A330-200")
     |> assign_async(:sounding, fn ->
       sounding =
         KangerlussuaqSounding
         |> order_by(desc: :id)
         |> limit(1)
         |> Repo.one()

       {:ok, %{sounding: sounding}}
     end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 09 · Kangerlussuaq sounding shelf
      </p>

      <h1>Kangerlussuaq sounding shelf</h1>
      <p class="lede">
        Clerk {@clerk} reads the last {@craft} sounding from the Repo.
        Mount does not wait.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={@sounding.loading} id="sounding-loading">Shelf still opening.</p>
      <p :if={@sounding.ok? && @sounding.result} id="sounding-oat">{@sounding.result.oat_c}</p>
      <p :if={@sounding.ok? && is_nil(@sounding.result)} id="sounding-empty">
        No sounding on the shelf.
      </p>
    </Layouts.catalog>
    """
  end
end
