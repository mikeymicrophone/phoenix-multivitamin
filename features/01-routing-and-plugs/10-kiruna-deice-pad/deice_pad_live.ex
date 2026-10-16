# Routing and plugs · 10 · Kiruna de-ice pad
#
# Teaches:
# - init/1 transforms options; under :runtime plug_init_mode it runs per spray

defmodule PhoenixMultivitaminWeb.KirunaDeicePadLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Kiruna de-ice pad")
     |> assign(:pad, "Kiruna de-ice pad")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 10 · Kiruna de-ice pad
      </p>

      <h1>Kiruna de-ice pad</h1>
      <p class="lede">
        {@pad} sprays a Boeing 737-800 before the iron-ore hop. The pad
        count is an init option. Under this app's test config, init itself
        runs on every spray.
      </p>

      <div class="watch-switcher">
        <.link id="open-pads" href={~p"/features/01-routing-and-plugs/10-kiruna-deice-pad/pads"}>
          Open the de-ice pad
        </.link>
      </div>
    </Layouts.catalog>
    """
  end
end
