# Async assigns · 04 · Van icing retry
#
# Teaches:
# - The failed tuple paints the reason
# - A retry event starts assign_async again

defmodule PhoenixMultivitaminWeb.VanIcingRetryLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Van icing retry")
     |> assign(:clerk, "Berfin")
     |> assign(:craft, "Antonov An-74")
     |> assign(:probe_dark?, true)
     |> fetch_icing()}
  end

  @impl true
  def handle_event("retry_probe", _params, socket) do
    {:noreply,
     socket
     |> assign(:probe_dark?, false)
     |> fetch_icing()}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 04 · Van icing retry
      </p>

      <h1>Van icing retry</h1>
      <p class="lede">
        Clerk {@clerk} reads icing on the {@craft}. The first probe is dark.
        Retry lights it.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={@icing.failed} id="icing-failed">{failed_reason(@icing.failed)}</p>
      <p :if={@icing.ok?} id="icing-value">{@icing.result}</p>

      <button id="retry-probe" type="button" phx-click="retry_probe">Retry probe</button>
    </Layouts.catalog>
    """
  end

  defp fetch_icing(socket) do
    dark? = socket.assigns.probe_dark?

    assign_async(socket, :icing, fn ->
      if dark? do
        {:error, :icing_probe_dark}
      else
        {:ok, %{icing: "trace ice at 8000"}}
      end
    end)
  end

  defp failed_reason({:error, reason}), do: inspect(reason)
  defp failed_reason(reason), do: inspect(reason)
end
