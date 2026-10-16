# Async assigns · 12 · Walvis Bay timeout
#
# Teaches:
# - A receive-after timeout returns {:error, :sounding_timeout}
# - The failed reason you actually get is {:error, :sounding_timeout}

defmodule PhoenixMultivitaminWeb.WalvisBayTimeoutLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Walvis Bay timeout")
     |> assign(:clerk, "Ndapewa")
     |> assign(:craft, "CRJ700")
     |> assign_async(:sounding, fn ->
       receive do
         :never -> {:ok, %{sounding: "late fog"}}
       after
         20 -> {:error, :sounding_timeout}
       end
     end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Async assigns · 12 · Walvis Bay timeout
      </p>

      <h1>Walvis Bay timeout</h1>
      <p class="lede">
        Clerk {@clerk} waits twenty milliseconds for a {@craft} sounding.
        The failed reason is the atom the function returned.
      </p>

      <p id="clerk-name">{@clerk}</p>
      <p id="craft-name">{@craft}</p>
      <p :if={@sounding.loading} id="sounding-loading">Sounding still over the desert fog.</p>
      <p :if={@sounding.failed} id="sounding-failed">{inspect(@sounding.failed)}</p>
    </Layouts.catalog>
    """
  end
end
