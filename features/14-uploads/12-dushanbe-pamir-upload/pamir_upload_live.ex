# Uploads · 12 · Dushanbe Pamir upload
#
# Teaches:
# - Content validation inside consume_uploaded_entries/3 returns {:postpone, receipt}
# - with/else maps read failures and bad headers to an error beside the entry

defmodule PhoenixMultivitaminWeb.DushanbePamirUploadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Dushanbe Pamir upload", "Farzona", "Antonov An-28")
     |> assign(form: upload_form(), report_errors: %{}, report_receipt: "No strip report filed")
     |> allow_upload(:report, accept: [".txt"], max_entries: 1, max_file_size: 20_000)}
  end

  @impl true
  def handle_event("check_report", _params, socket), do: {:noreply, socket}

  def handle_event("file_report", _params, socket) do
    case readiness(socket, :report) do
      :ready ->
        case consume_uploaded_entries(socket, :report, &inspect_report/2) do
          [{:accepted, name}] ->
            {:noreply, assign(socket, report_receipt: name, report_errors: %{})}

          [{:rejected, ref, reason}] ->
            {:noreply, assign(socket, :report_errors, %{ref => reason})}
        end

      status -> {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  def handle_event("withdraw_report", %{"ref" => ref}, socket) do
    {:noreply,
     socket
     |> cancel_upload(:report, ref)
     |> update(:report_errors, &Map.delete(&1, ref))}
  end

  defp inspect_report(%{path: path}, entry) do
    with {:ok, contents} <- File.read(path),
         <<"PAMIR\n", _observations::binary>> <- contents do
      {:ok, {:accepted, entry.client_name}}
    else
      {:error, _reason} -> {:postpone, {:rejected, entry.ref, "The strip report could not be read."}}
      _contents -> {:postpone, {:rejected, entry.ref, "The first line must be PAMIR."}}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 12 · Dushanbe Pamir upload
      </p>
      <header class="masthead">
        <h1>Dushanbe Pamir upload</h1>
        <p class="lede">
          Farzona checks the PAMIR header inside a mountain strip report and keeps a rejected
          report visible for withdrawal.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="report-form" phx-change="check_report" phx-submit="file_report"
        class="scenario my-6 space-y-4">
        <label for={@uploads.report.ref} class="block font-semibold">Strip report</label>
        <.live_file_input upload={@uploads.report} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="report-queue" upload={@uploads.report} cancel_event="withdraw_report">
          <:detail :let={entry}>
            <p :if={Map.has_key?(@report_errors, entry.ref)} id={"report-error-#{entry.ref}"}
              role="alert" class="text-red-800">{Map.get(@report_errors, entry.ref)}</p>
          </:detail>
        </.upload_queue>
        <button id="file-report" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File strip report
        </button>
      </.form>
      <p id="report-receipt">{@report_receipt}</p>
    </Layouts.app>
    """
  end
end
