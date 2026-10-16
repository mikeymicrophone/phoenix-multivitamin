# Uploads · 01 · Centrair Tokoname plate scan
#
# Teaches:
# - allow_upload/3 with keyword options held in a module attribute
# - Pattern matching completed and pending upload tuples before consumption

defmodule PhoenixMultivitaminWeb.CentrairTokonamePlateScanLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @plate_options [accept: ~w(.png .pdf), max_entries: 1, max_file_size: 200_000]
  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_scenario("Centrair Tokoname plate scan", "Aiko", "Boeing 787-9")
      |> assign(form: upload_form(), plate_receipt: "No plate filed")

    {:ok, allow_upload(socket, :plate, @plate_options)}
  end

  @impl true
  def handle_event("inspect_plate", _params, socket), do: {:noreply, socket}

  def handle_event("file_plate", _params, socket) do
    case {uploaded_entries(socket, :plate), readiness(socket, :plate)} do
      {{[_plate], []}, :ready} ->
        [receipt] = consume_uploaded_entries(socket, :plate, fn %{path: path}, entry ->
          {:ok, "#{entry.client_name} · #{File.stat!(path).size} bytes"}
        end)

        {:noreply, assign(socket, :plate_receipt, receipt)}

      {_entries, status} ->
        {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 01 · Centrair Tokoname plate scan
      </p>
      <header class="masthead">
        <h1>Centrair Tokoname plate scan</h1>
        <p class="lede">
          Aiko checks one engine plate scan before the Centrair maintenance handover.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="plate-form" phx-change="inspect_plate" phx-submit="file_plate"
        class="scenario my-6 space-y-4">
        <label for={@uploads.plate.ref} class="block font-semibold">Engine plate</label>
        <.live_file_input upload={@uploads.plate} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="plate-queue" upload={@uploads.plate} />
        <button id="file-plate" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File engine plate
        </button>
      </.form>
      <p id="plate-receipt">{@plate_receipt}</p>
    </Layouts.app>
    """
  end
end
