# Uploads · 09 · Tashkent Registan scan
#
# Teaches:
# - Named progress callback with explicit UploadEntry struct matching
# - Map updates and Enum.reduce/3 compute byte-weighted progress instead of counting files

defmodule PhoenixMultivitaminWeb.TashkentRegistanScanLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Tashkent Registan scan", "Aziza", "Boeing 767-300ER")
     |> assign(form: upload_form(), received_percent: 0, filed_bytes: 0)
     |> allow_upload(:briefs, accept: [".txt"], max_entries: 3, max_file_size: 40_000,
       progress: &brief_progress/3)}
  end

  @impl true
  def handle_event("check_briefs", _params, socket), do: {:noreply, socket}

  def handle_event("file_briefs", _params, socket) do
    case readiness(socket, :briefs) do
      :ready ->
        sizes = consume_uploaded_entries(socket, :briefs, fn %{path: path}, _entry ->
          {:ok, File.stat!(path).size}
        end)
        {:noreply, assign(socket, filed_bytes: Enum.sum(sizes), received_percent: 0)}

      status -> {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  defp brief_progress(:briefs, %Phoenix.LiveView.UploadEntry{} = entry, socket) do
    entries =
      socket.assigns.uploads.briefs.entries
      |> Map.new(&{&1.ref, {&1.progress, &1.client_size}})
      |> Map.put(entry.ref, {entry.progress, entry.client_size})

    {weighted, total} = Enum.reduce(entries, {0, 0}, fn {_ref, {percent, bytes}}, {sum, size} ->
      {sum + percent * bytes, size + bytes}
    end)

    percent = if total == 0, do: 0, else: div(weighted, total)
    {:noreply, assign(socket, :received_percent, percent)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 09 · Tashkent Registan scan
      </p>
      <header class="masthead">
        <h1>Tashkent Registan scan</h1>
        <p class="lede">
          Aziza watches byte-weighted progress as Tashkent crew briefing bundles arrive, then
          files the completed packet.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="briefs-form" phx-change="check_briefs" phx-submit="file_briefs"
        class="scenario my-6 space-y-4">
        <label for={@uploads.briefs.ref} class="block font-semibold">Crew briefs</label>
        <.live_file_input upload={@uploads.briefs} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="briefs-queue" upload={@uploads.briefs} />
        <button id="file-briefs" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File crew briefs
        </button>
      </.form>
      <p id="brief-progress">{@received_percent}% received</p>
      <p id="filed-bytes">{@filed_bytes} bytes filed</p>
    </Layouts.app>
    """
  end
end
