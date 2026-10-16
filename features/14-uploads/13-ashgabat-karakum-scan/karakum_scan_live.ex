# Uploads · 13 · Ashgabat Karakum scan
#
# Teaches:
# - A bounded multi-file queue, cancellation, and streamed storage receipts
# - A per-mount archive batch, safe server-generated filenames, and fallible copy with postponed failures

defmodule PhoenixMultivitaminWeb.AshgabatKarakumScanLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  alias PhoenixMultivitamin.AshgabatArchive, as: Archive

  @impl true
  def mount(_params, _session, socket) do
    batch = Base.url_encode64(:crypto.strong_rand_bytes(12), padding: false)

    {:ok,
     socket
     |> assign_scenario("Ashgabat Karakum scan", "Mähriban", "Boeing 737-700")
     |> assign(form: upload_form(), archive_batch: batch, stored_count: 0, storage_notice: "No plates stored")
     |> stream_configure(:plates, dom_id: &"stored-plate-#{&1.id}")
     |> stream(:plates, [])
     |> allow_upload(:plates, accept: ~w(.png .pdf), max_entries: 3, max_file_size: 200_000)}
  end

  @impl true
  def handle_event("check_plates", _params, socket), do: {:noreply, socket}

  def handle_event("withdraw_plate", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :plates, ref)}
  end

  def handle_event("store_plates", _params, socket) do
    case readiness(socket, :plates) do
      :ready ->
        batch = socket.assigns.archive_batch
        outcomes = consume_uploaded_entries(socket, :plates, fn %{path: path}, entry ->
          case Archive.store(batch, entry.uuid, path) do
            {:ok, destination} ->
              {:ok, {:stored, %{id: entry.uuid, name: entry.client_name, path: destination}}}
            {:error, reason} ->
              {:postpone, {:deferred, reason}}
          end
        end)

        stored = for {:stored, receipt} <- outcomes, do: receipt
        deferred = Enum.count(outcomes, &match?({:deferred, _reason}, &1))
        notice = if deferred == 0, do: "Packet stored", else: "Storage unavailable; retry queued plates."

        {:noreply,
         socket
         |> stream(:plates, stored)
         |> update(:stored_count, &(&1 + length(stored)))
         |> assign(:storage_notice, notice)}

      status -> {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 13 · Ashgabat Karakum scan
      </p>
      <header class="masthead">
        <h1>Ashgabat Karakum scan</h1>
        <p class="lede">
          Mähriban assembles Karakum dispatch plates, withdraws outdated scans, and stores the
          remaining packet in a private archive.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="plates-form" phx-change="check_plates" phx-submit="store_plates"
        class="scenario my-6 space-y-4">
        <label for={@uploads.plates.ref} class="block font-semibold">Dispatch plates</label>
        <.live_file_input upload={@uploads.plates} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="plates-queue" upload={@uploads.plates} cancel_event="withdraw_plate" />
        <button id="store-plates" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File dispatch plates
        </button>
      </.form>
      <p id="storage-notice" role="status">{@storage_notice}</p>
      <p id="stored-count">{@stored_count} plates stored</p>
      <ul id="stored-plates" phx-update="stream" class="watch-log">
        <li :for={{dom_id, plate} <- @streams.plates} id={dom_id} data-path={plate.path}>
          {plate.name} · stored privately
        </li>
      </ul>
    </Layouts.app>
    """
  end
end
