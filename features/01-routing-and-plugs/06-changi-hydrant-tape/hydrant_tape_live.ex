# Routing and plugs · 06 · Changi hydrant tape
#
# Teaches:
# - Pipeline assigns sit on the conn, not automatically on the LiveView socket
# - assign_new/3 copies a conn assign on the disconnected render
# - The connected mount runs the fallback; the plug's shift does not survive
# - Without assign_new/3, socket.assigns does not already have the plug's key

defmodule PhoenixMultivitaminWeb.ChangiHydrantTapeLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket_had_shift? = Map.has_key?(socket.assigns, :shift)

    {:ok,
     socket
     |> assign(:page_title, "Changi hydrant tape")
     |> assign(:operator, "Siti")
     |> assign(:socket_had_shift?, socket_had_shift?)
     |> assign_new(:shift, fn -> "no shift from the plug" end)
     |> assign_new(:hydrant, fn -> "no hydrant from the plug" end)
     |> assign_new(:apron, fn -> "no apron from the plug" end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 06 · Changi hydrant tape
      </p>

      <h1>Changi hydrant tape</h1>
      <p class="lede">
        Operator {@operator} keeps two doors onto the Changi hydrant ring.
        The controller tape reads pipeline assigns directly. This LiveView
        only sees them through <code>assign_new/3</code>.
      </p>

      <p
        id="socket-banner"
        class={["mount-banner", if(@socket_had_shift?, do: "connected-mount", else: "static-mount")]}
      >
        <%= if @socket_had_shift? do %>
          The socket already had a shift before assign_new/3.
        <% else %>
          The socket had no shift key until assign_new/3.
        <% end %>
      </p>

      <dl class="station-meta">
        <dt>Hydrant</dt>
        <dd id="hydrant-name">{@hydrant}</dd>
        <dt>Shift</dt>
        <dd id="shift-name">{@shift}</dd>
        <dt>Socket had shift</dt>
        <dd id="socket-had-shift">{if @socket_had_shift?, do: "yes", else: "no"}</dd>
      </dl>

      <div class="watch-switcher">
        <.link
          id="open-tape"
          href={~p"/features/01-routing-and-plugs/06-changi-hydrant-tape/tape"}
        >
          Controller tape
        </.link>
        <.link
          id="open-hydrant"
          href={~p"/features/01-routing-and-plugs/06-changi-hydrant-tape/hydrant"}
        >
          LiveView hydrant
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
