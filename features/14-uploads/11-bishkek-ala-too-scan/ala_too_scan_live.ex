# Uploads · 11 · Bishkek Ala-Too scan
#
# Teaches:
# - Two independent upload configurations in one form with live_img_preview
# - A named detail slot receives each entry with :let; with requires both queues

defmodule PhoenixMultivitaminWeb.BishkekAlaTooScanLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Bishkek Ala-Too scan", "Aida", "DHC-6 Twin Otter")
     |> assign(form: upload_form(), pair_receipt: "No landing pair filed")
     |> allow_upload(:overview, accept: [".png"], max_entries: 1, max_file_size: 100_000)
     |> allow_upload(:detail, accept: [".png"], max_entries: 1, max_file_size: 100_000)}
  end

  @impl true
  def handle_event("check_landing", _params, socket), do: {:noreply, socket}

  def handle_event("file_landing", _params, socket) do
    with :ready <- readiness(socket, :overview),
         :ready <- readiness(socket, :detail) do
      names =
        for view <- [:overview, :detail],
            name <- consume_uploaded_entries(socket, view, fn _metadata, entry -> {:ok, entry.client_name} end) do
          name
        end

      {:noreply, assign(socket, :pair_receipt, Enum.join(names, " / "))}
    else
      status -> {:noreply, put_flash(socket, :error, "Both landing views are required. " <> readiness_message(status))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 11 · Bishkek Ala-Too scan
      </p>
      <header class="masthead">
        <h1>Bishkek Ala-Too scan</h1>
        <p class="lede">
          Aida compares an Ala-Too rescue landing overview with its touchdown detail before
          accepting the pair.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="landing-form" phx-change="check_landing" phx-submit="file_landing"
        class="scenario my-6 grid gap-5 sm:grid-cols-2">
        <section>
          <label for={@uploads.overview.ref}>Landing overview · PNG</label>
          <.live_file_input upload={@uploads.overview} class="my-3 block w-full" />
          <.upload_queue id="overview-queue" upload={@uploads.overview} preview={true}>
            <:detail :let={entry}><small>{entry.client_size} bytes · landing overview</small></:detail>
          </.upload_queue>
        </section>
        <section>
          <label for={@uploads.detail.ref}>Touchdown detail · PNG</label>
          <.live_file_input upload={@uploads.detail} class="my-3 block w-full" />
          <.upload_queue id="detail-queue" upload={@uploads.detail} preview={true}>
            <:detail :let={entry}><small>{entry.client_size} bytes · touchdown detail</small></:detail>
          </.upload_queue>
        </section>
        <button id="file-landing" type="submit" phx-disable-with="Filing pair…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800">
          File landing pair
        </button>
      </.form>
      <p id="pair-receipt">{@pair_receipt}</p>
    </Layouts.app>
    """
  end
end
