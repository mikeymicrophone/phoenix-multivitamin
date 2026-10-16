# Uploads · 06 · Harbin ice-city upload
#
# Teaches:
# - MIME accept lists populate the file input and validate entries
# - Enum.frequencies_by/2 and a map-oriented receipt pipeline

defmodule PhoenixMultivitaminWeb.HarbinIceCityUploadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign_scenario(socket, "Harbin ice-city upload", "Yun", "Airbus A320neo")
      |> assign(form: upload_form(), photo_receipt: "No photographs filed")

    {:ok,
     Phoenix.LiveView.allow_upload(socket, :photos,
       accept: ["image/jpeg", "image/png"],
       max_entries: 4,
       max_file_size: 100_000
     )}
  end

  @impl true
  def handle_event("check_photos", _params, socket), do: {:noreply, socket}

  def handle_event("withdraw_photo", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :photos, ref)}
  end

  def handle_event("file_photos", _params, socket) do
    with :ready <- readiness(socket, :photos) do
      formats = consume_uploaded_entries(socket, :photos, fn _metadata, entry ->
        {:ok, String.downcase(Path.extname(entry.client_name))}
      end)

      receipt =
        formats
        |> Enum.frequencies_by(& &1)
        |> Enum.sort()
        |> Enum.map_join(", ", fn {format, count} -> "#{format}: #{count}" end)

      {:noreply, assign(socket, :photo_receipt, receipt)}
    else
      status -> {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 06 · Harbin ice-city upload
      </p>
      <header class="masthead">
        <h1>Harbin ice-city upload</h1>
        <p class="lede">
          Yun sorts Harbin wing inspection photographs into JPEG and PNG handover bundles.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="photos-form" phx-change="check_photos" phx-submit="file_photos"
        class="scenario my-6 space-y-4">
        <label for={@uploads.photos.ref} class="block font-semibold">Wing photographs</label>
        <.live_file_input upload={@uploads.photos} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="photos-queue" upload={@uploads.photos} cancel_event="withdraw_photo" />
        <button id="file-photos" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File wing photographs
        </button>
      </.form>
      <p id="photo-receipt">{@photo_receipt}</p>
    </Layouts.app>
    """
  end
end
