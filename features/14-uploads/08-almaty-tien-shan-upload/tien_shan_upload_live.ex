# Uploads · 08 · Almaty Tian Shan upload
#
# Teaches:
# - auto_upload and phx-drop-target start transfers without submit
# - A progress function capture consumes only the completed entry, then streams its receipt

defmodule PhoenixMultivitaminWeb.AlmatyTienShanUploadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Almaty Tian Shan upload", "Aigerim", "Mil Mi-171")
     |> assign(form: upload_form(), track_count: 0)
     |> stream(:tracks, [])
     |> allow_upload(:tracks, accept: [".txt"], max_entries: 3, max_file_size: 20_000,
       auto_upload: true, progress: &receive_track/3)}
  end

  @impl true
  def handle_event("check_tracks", _params, socket), do: {:noreply, socket}

  defp receive_track(:tracks, %{done?: true} = entry, socket) do
    track = consume_uploaded_entry(socket, entry, fn %{path: path} ->
      digest = :crypto.hash(:sha256, File.read!(path)) |> Base.encode16(case: :lower)
      {:ok, %{id: entry.uuid, name: entry.client_name, digest: digest}}
    end)

    {:noreply, socket |> stream_insert(:tracks, track) |> update(:track_count, &(&1 + 1))}
  end

  defp receive_track(:tracks, _entry, socket), do: {:noreply, socket}

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 08 · Almaty Tian Shan upload
      </p>
      <header class="masthead">
        <h1>Almaty Tian Shan upload</h1>
        <p class="lede">
          Aigerim drops Tian Shan rescue-track logs onto the Almaty desk; each completed
          transfer gets its own digest.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="tracks-form" phx-change="check_tracks"
        class="scenario my-6 space-y-4">
        <div id="track-drop" phx-drop-target={@uploads.tracks.ref}
          class="rounded-xl border-2 border-dashed border-green-800 p-8 transition hover:bg-green-50">
          <label for={@uploads.tracks.ref}>Drop rescue-track logs or choose files</label>
          <.live_file_input upload={@uploads.tracks} class="mt-3 block w-full" />
        </div>
        <.upload_queue id="tracks-queue" upload={@uploads.tracks} />
      </.form>
      <p id="track-count">{@track_count} tracks received</p>
      <ul id="track-receipts" phx-update="stream" class="watch-log">
        <li :for={{dom_id, track} <- @streams.tracks} id={dom_id}>
          {track.name} · <code>{track.digest}</code>
        </li>
      </ul>
    </Layouts.app>
    """
  end
end
