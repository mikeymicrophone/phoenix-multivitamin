# Uploads · 10 · Samarkand silk upload
#
# Teaches:
# - external presigning returns uploader metadata and a short-lived signed URL
# - External consumption receives archive metadata, not a local temporary path

defmodule PhoenixMultivitaminWeb.SamarkandSilkUploadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  alias PhoenixMultivitamin.SamarkandArchive, as: Archive

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Samarkand silk upload", "Madina", "Airbus A321neo")
     |> assign(form: upload_form(), archive_receipt: "No inventory archived")
     |> allow_upload(:inventory, accept: [".txt"], max_entries: 1, max_file_size: 20_000,
       external: &presign_inventory/2)}
  end

  @impl true
  def handle_event("check_inventory", _params, socket), do: {:noreply, socket}

  def handle_event("file_inventory", _params, socket) do
    with :ready <- readiness(socket, :inventory) do
      [receipt] = consume_uploaded_entries(socket, :inventory, fn %{key: key}, entry ->
        if File.regular?(Archive.path(key)) do
          {:ok, "#{entry.client_name} · archived"}
        else
          {:postpone, "Archive object is missing; withdraw and retry."}
        end
      end)
      {:noreply, assign(socket, :archive_receipt, receipt)}
    else
      status -> {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  def handle_event("withdraw_inventory", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :inventory, ref)}
  end

  def presign_inventory(entry, socket) do
    key = Base.url_encode64(:crypto.strong_rand_bytes(18), padding: false)
    token = Archive.sign(key, entry.client_size)
    metadata = %{
      uploader: "FlightArchive",
      key: key,
      url: ~p"/features/14-uploads/10-samarkand-silk-upload/archive/#{token}"
    }
    {:ok, metadata, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 10 · Samarkand silk upload
      </p>
      <header class="masthead">
        <h1>Samarkand silk upload</h1>
        <p class="lede">
          Madina sends Samarkand cabin inventory logs through a signed archive endpoint while
          LiveView tracks the external transfer.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="inventory-form" phx-change="check_inventory" phx-submit="file_inventory"
        class="scenario my-6 space-y-4">
        <label for={@uploads.inventory.ref} class="block font-semibold">Cabin inventory</label>
        <.live_file_input upload={@uploads.inventory} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="inventory-queue" upload={@uploads.inventory} cancel_event="withdraw_inventory" />
        <button id="file-inventory" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File cabin inventory
        </button>
      </.form>
      <p id="archive-receipt">{@archive_receipt}</p>
    </Layouts.app>
    """
  end
end
