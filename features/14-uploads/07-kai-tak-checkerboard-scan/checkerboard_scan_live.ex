# Uploads · 07 · Kai Tak checkerboard scan
#
# Teaches:
# - max_file_size rejects a file before consumption; cancellation enables a replacement
# - cond separates invalid, unfinished, empty, and completed states

defmodule PhoenixMultivitaminWeb.KaiTakCheckerboardScanLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Kai Tak checkerboard scan", "Wai", "Boeing 747-200")
     |> assign(form: upload_form(), caption_receipt: "No caption filed")
     |> allow_upload(:caption, accept: [".txt"], max_entries: 1, max_file_size: 128)}
  end

  @impl true
  def handle_event("check_caption", _params, socket), do: {:noreply, socket}

  def handle_event("withdraw_caption", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :caption, ref)}
  end

  def handle_event("file_caption", _params, socket) do
    status = readiness(socket, :caption)

    cond do
      status == :invalid -> {:noreply, put_flash(socket, :error, "Replace the caption with at most 128 bytes.")}
      status == :in_progress -> {:noreply, put_flash(socket, :error, readiness_message(status))}
      status == :empty -> {:noreply, put_flash(socket, :error, readiness_message(status))}
      true ->
        [caption] = consume_uploaded_entries(socket, :caption, fn %{path: path}, _entry ->
          {:ok, path |> File.read!() |> String.trim()}
        end)
        {:noreply, assign(socket, :caption_receipt, caption)}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 07 · Kai Tak checkerboard scan
      </p>
      <header class="masthead">
        <h1>Kai Tak checkerboard scan</h1>
        <p class="lede">
          Wai loads a compact historical Checkerboard briefing caption into the Kai Tak training
          archive.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="caption-form" phx-change="check_caption" phx-submit="file_caption"
        class="scenario my-6 space-y-4">
        <label for={@uploads.caption.ref} class="block font-semibold">Briefing caption</label>
        <.live_file_input upload={@uploads.caption} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="caption-queue" upload={@uploads.caption} cancel_event="withdraw_caption" />
        <button id="file-caption" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File briefing caption
        </button>
      </.form>
      <p id="caption-receipt">{@caption_receipt}</p>
    </Layouts.app>
    """
  end
end
