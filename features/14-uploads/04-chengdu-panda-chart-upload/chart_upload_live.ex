# Uploads · 04 · Chengdu panda chart upload
#
# Teaches:
# - cancel_upload/3 removes one referenced entry
# - Guarded payloads and a pinned reference in a membership predicate

defmodule PhoenixMultivitaminWeb.ChengduPandaChartUploadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Chengdu panda chart upload", "Lin", "Airbus A350-900")
     |> assign(form: upload_form(), chart_count: 0)
     |> allow_upload(:charts, accept: [".pdf"], max_entries: 3, max_file_size: 200_000)}
  end

  @impl true
  def handle_event("check_charts", _params, socket), do: {:noreply, socket}

  def handle_event("withdraw_chart", %{"ref" => ref}, socket) when is_binary(ref) do
    if Enum.any?(socket.assigns.uploads.charts.entries, fn
         %{ref: ^ref} -> true
         _entry -> false
       end) do
      {:noreply, cancel_upload(socket, :charts, ref)}
    else
      {:noreply, put_flash(socket, :error, "That chart is no longer queued.")}
    end
  end

  def handle_event("withdraw_chart", _params, socket) do
    {:noreply, put_flash(socket, :error, "Choose a queued chart to withdraw.")}
  end

  def handle_event("file_charts", _params, socket) do
    if readiness(socket, :charts) == :ready do
      charts = consume_uploaded_entries(socket, :charts, fn _metadata, entry -> {:ok, entry.client_name} end)
      {:noreply, update(socket, :chart_count, &(&1 + length(charts)))}
    else
      {:noreply, put_flash(socket, :error, "Finish the remaining charts before filing.")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 04 · Chengdu panda chart upload
      </p>
      <header class="masthead">
        <h1>Chengdu panda chart upload</h1>
        <p class="lede">
          Lin withdraws superseded Chengdu diversion charts without disturbing the charts still
          queued.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="charts-form" phx-change="check_charts" phx-submit="file_charts"
        class="scenario my-6 space-y-4">
        <label for={@uploads.charts.ref} class="block font-semibold">Diversion charts</label>
        <.live_file_input upload={@uploads.charts} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="charts-queue" upload={@uploads.charts} cancel_event="withdraw_chart" />
        <button id="file-charts" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File diversion charts
        </button>
      </.form>
      <p id="chart-count">{@chart_count} charts filed</p>
    </Layouts.app>
    """
  end
end
