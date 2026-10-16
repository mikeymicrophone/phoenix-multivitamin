# Uploads · 02 · Macau Taipa logbook upload
#
# Teaches:
# - live_file_input/1 beside a changeset-backed captain input
# - Guarded function heads, with/else, and rejected captain behavior

defmodule PhoenixMultivitaminWeb.MacauTaipaLogbookUploadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    captain_form = captain_form(%{"captain" => "Inês"})

    {:ok,
     socket
     |> assign_scenario("Macau Taipa logbook upload", "Inês", "ATR 72-600")
     |> assign(form: captain_form, logbook_receipt: "No sectors filed")
     |> allow_upload(:logbook, accept: [".txt"], max_entries: 1, max_file_size: 20_000)}
  end

  @impl true
  def handle_event("check_captain", %{"logbook" => captain_params}, socket) do
    {:noreply, assign(socket, :form, captain_form(captain_params))}
  end

  def handle_event("file_logbook", %{"logbook" => %{"captain" => captain}}, socket)
      when is_binary(captain) do
    with true <- String.trim(captain) != "",
         :ready <- readiness(socket, :logbook) do
      [sectors] = consume_uploaded_entries(socket, :logbook, fn %{path: path}, _entry ->
        count =
          path
          |> File.read!()
          |> String.split("\n", trim: true)
          |> Enum.reject(&(String.trim(&1) == ""))
          |> length()
        {:ok, count}
      end)

      {:noreply, assign(socket, :logbook_receipt, "#{String.trim(captain)} · #{sectors} sectors")}
    else
      false -> {:noreply, put_flash(socket, :error, "Name the captain before filing the logbook.")}
      status -> {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  def handle_event("file_logbook", _params, socket) do
    {:noreply, put_flash(socket, :error, "Name the captain before filing the logbook.")}
  end

  defp captain_form(params) do
    {%{}, %{captain: :string}}
    |> Ecto.Changeset.cast(params, [:captain])
    |> Ecto.Changeset.validate_required([:captain])
    |> to_form(as: :logbook)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 02 · Macau Taipa logbook upload
      </p>
      <header class="masthead">
        <h1>Macau Taipa logbook upload</h1>
        <p class="lede">
          Inês pairs a Taipa night-sector logbook with its captain before counting the written
          sectors.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="logbook-form" phx-change="check_captain" phx-submit="file_logbook"
        class="scenario my-6 space-y-4">
        <.input field={@form[:captain]} label="Captain" type="text" />
        <label for={@uploads.logbook.ref} class="block font-semibold">Sector logbook</label>
        <.live_file_input upload={@uploads.logbook} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="logbook-queue" upload={@uploads.logbook} />
        <button id="file-logbook" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File sector logbook
        </button>
      </.form>
      <p id="logbook-receipt">{@logbook_receipt}</p>
    </Layouts.app>
    """
  end
end
