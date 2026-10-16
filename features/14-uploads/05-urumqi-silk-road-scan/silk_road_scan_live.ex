# Uploads · 05 · Ürümqi silk-road scan
#
# Teaches:
# - max_entries produces a configuration error separately from entry errors
# - Keyword.merge/2 specializes limits; names are sorted before a receipt is built

defmodule PhoenixMultivitaminWeb.UrumqiSilkRoadScanLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    limits = Keyword.merge([accept: [".txt"], max_file_size: 10_000], max_entries: 2)

    socket = assign_scenario(socket, "Ürümqi silk-road scan", "Dilnur", "Boeing 737-800")
    socket = assign(socket, form: upload_form(), dispatch_receipt: "No releases filed")

    {:ok, allow_upload(socket, :releases, limits)}
  end

  @impl true
  def handle_event("check_releases", _params, socket), do: {:noreply, socket}

  def handle_event("withdraw_release", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :releases, ref)}
  end

  def handle_event("file_releases", _params, socket) do
    case readiness(socket, :releases) do
      :ready ->
        names = consume_uploaded_entries(socket, :releases, fn _metadata, entry -> {:ok, entry.client_name} end)
        receipt = names |> Enum.sort() |> Enum.join(" + ")
        {:noreply, assign(socket, :dispatch_receipt, receipt)}

      status -> {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 05 · Ürümqi silk-road scan
      </p>
      <header class="masthead">
        <h1>Ürümqi silk-road scan</h1>
        <p class="lede">
          Dilnur keeps the Ürümqi dispatch packet to two releases and withdraws the extra sector
          sheet.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="releases-form" phx-change="check_releases" phx-submit="file_releases"
        class="scenario my-6 space-y-4">
        <label for={@uploads.releases.ref} class="block font-semibold">Dispatch releases</label>
        <.live_file_input upload={@uploads.releases} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="releases-queue" upload={@uploads.releases} cancel_event="withdraw_release" />
        <button id="file-releases" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File dispatch releases
        </button>
      </.form>
      <p id="dispatch-receipt">{@dispatch_receipt}</p>
    </Layouts.app>
    """
  end
end
