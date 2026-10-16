# Async assigns · 09 · Kangerlussuaq sounding shelf
#
# Teaches:
# - stream_async reads the Repo into a stream without blocking render
# - The dead render is loading; the row arrives after connect
# - case separates an empty shelf from a sounding record

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
     |> assign_scenario("Kangerlussuaq sounding shelf", "Malik", "Airbus A330-200")
     |> stream_async(
       :soundings,
       fn ->
         sounding =
           KangerlussuaqSounding
           |> order_by(desc: :id)
           |> limit(1)
           |> Repo.one()

         case sounding do
           nil -> {:ok, [], reset: true}
           %KangerlussuaqSounding{} = sounding -> {:ok, [sounding], reset: true}
         end
       end,
       reset: true
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 09 · Kangerlussuaq sounding shelf
      </p>

      <h1>Kangerlussuaq sounding shelf</h1>
      <p class="lede">
        Clerk {@clerk} reads the last {@craft} sounding from the Repo.
        Mount does not wait.
      </p>

      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.async_result assign={@soundings}>
        <:loading><p id="sounding-loading">Shelf still opening.</p></:loading>
        <:failed><p id="sounding-failed">The sounding shelf could not be read.</p></:failed>
        <p id="sounding-ready">Sounding shelf opened.</p>
      </.async_result>

      <div id="soundings" phx-update="stream">
        <p id="sounding-empty" class={if(@soundings.ok?, do: "hidden only:block", else: "hidden")}>
          No sounding on the shelf.
        </p>
        <article :for={{dom_id, sounding} <- @streams.soundings} id={dom_id}>
          <p id="sounding-oat">{sounding.oat_c}</p>
        </article>
      </div>
    </Layouts.app>
    """
  end
end
