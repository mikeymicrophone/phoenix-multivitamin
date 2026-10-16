defmodule PhoenixMultivitaminWeb.BarilocheChinookBriefHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Controllers and JSON · 05 · Bariloche Chinook brief
      </p>

      <h1>Bariloche Chinook brief</h1>
      <p class="lede">
        Officer {@officer} accepted the {@craft} brief through the {@valley}.
        The status is {@status_name}; the body is still this page.
      </p>

      <dl class="station-meta">
        <dt>Officer</dt>
        <dd id="brief-officer">{@officer}</dd>
        <dt>Craft</dt>
        <dd id="brief-craft">{@craft}</dd>
        <dt>Valley</dt>
        <dd id="brief-valley">{@valley}</dd>
        <dt>Status</dt>
        <dd id="brief-status">{@status_name}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/03-controllers-and-json/05-bariloche-chinook-brief"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
