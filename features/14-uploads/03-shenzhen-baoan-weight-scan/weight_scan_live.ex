# Uploads · 03 · Shenzhen Baoan weight scan
#
# Teaches:
# - consume_uploaded_entries/3 transforms temporary files into enforced receipt structs
# - A filtered comprehension, Integer.parse/1, Enum.reduce/3, and String.Chars

defmodule PhoenixMultivitaminWeb.ShenzhenBaoanWeightScanLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  import PhoenixMultivitaminWeb.UploadHelpers

  alias PhoenixMultivitamin.ShenzhenWeightReceipt, as: WeightReceipt

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_scenario("Shenzhen Baoan weight scan", "Mei", "Boeing 777F")
     |> assign(form: upload_form(), gross_kg: 0)
     |> stream(:receipts, [])
     |> allow_upload(:weights, accept: [".csv"], max_entries: 3, max_file_size: 20_000)}
  end

  @impl true
  def handle_event("check_weights", _params, socket), do: {:noreply, socket}

  def handle_event("file_weights", _params, socket) do
    case readiness(socket, :weights) do
      :ready ->
        receipts = consume_uploaded_entries(socket, :weights, fn %{path: path}, entry ->
          kilograms =
            for row <- String.split(File.read!(path), "\n", trim: true),
                [_pallet, weight] <- [String.split(row, ",")],
                {kg, ""} <- [Integer.parse(String.trim(weight))],
                kg > 0,
                reduce: 0 do
              total -> total + kg
            end

          {:ok, %WeightReceipt{id: entry.uuid, filename: entry.client_name, kilograms: kilograms}}
        end)

        gross_kg = Enum.reduce(receipts, socket.assigns.gross_kg, &(&1.kilograms + &2))
        {:noreply, socket |> assign(:gross_kg, gross_kg) |> stream(:receipts, receipts)}

      status ->
        {:noreply, put_flash(socket, :error, readiness_message(status))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} variant={:catalog}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Uploads · 03 · Shenzhen Baoan weight scan
      </p>
      <header class="masthead">
        <h1>Shenzhen Baoan weight scan</h1>
        <p class="lede">
          Mei totals positive pallet weights from Baoan cargo CSVs and posts typed receipts to
          the loading board.
        </p>
      </header>
      <.scenario_identity clerk={@clerk} craft={@craft} />
      <.form for={@form} id="weights-form" phx-change="check_weights" phx-submit="file_weights"
        class="scenario my-6 space-y-4">
        <label for={@uploads.weights.ref} class="block font-semibold">Pallet weights</label>
        <.live_file_input upload={@uploads.weights} class="block w-full rounded-lg border border-stone-300 p-3" />
        <.upload_queue id="weights-queue" upload={@uploads.weights} />
        <button id="file-weights" type="submit" phx-disable-with="Filing…"
          class="rounded-lg bg-green-900 px-5 py-2 text-white transition hover:bg-green-800 disabled:opacity-50">
          File pallet weights
        </button>
      </.form>
      <p id="gross-weight">{@gross_kg} kg</p>
      <ul id="weight-receipts" phx-update="stream" class="watch-log">
        <li :for={{dom_id, receipt} <- @streams.receipts} id={dom_id}>{to_string(receipt)}</li>
      </ul>
    </Layouts.app>
    """
  end
end
