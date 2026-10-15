defmodule PhoenixMultivitaminWeb.PlannedLive do
  @moduledoc """
  Placeholder page for a slot that is not bottled yet. Copy comes from the
  feature's `feature.exs` so this module stays free of scenario names.
  """
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.Catalog

  @impl true
  def mount(%{"feature" => feature_slug, "example" => example_slug}, _session, socket) do
    case Catalog.fetch_slot(feature_slug, example_slug) do
      %{feature: feature, slot: slot} ->
        {:ok,
         socket
         |> assign(:page_title, "#{slot.title} · planned")
         |> assign(:feature, feature)
         |> assign(:slot, slot)
         |> assign(:missing, false)}

      nil ->
        {:ok,
         socket
         |> assign(:page_title, "Unknown slot")
         |> assign(:feature, nil)
         |> assign(:slot, nil)
         |> assign(:missing, true)}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link>
        <%= if @feature do %>
          · {@feature.title}
        <% end %>
      </p>

      <%= if @missing do %>
        <h1>This slot is not in the catalog</h1>
        <p class="lede">
          Every feature lists thirteen slots in its folder. Pick one from the
          <.link navigate={~p"/"}>catalog</.link>
          or see CONTRIBUTING.md before opening a new one.
        </p>
      <% else %>
        <h1>{@slot.title}</h1>
        <p class="dose-count">planned · {pad(@feature.number)} · {pad(@slot.number)} of 13</p>
        <div class="scenario">
          <p>
            This slot is planned, not bottled. Copy the reference scenario in
            LiveView lifecycle and events when you fill it: a LiveView or
            controller in the slot's own folder, a README, and an ExUnit test
            beside the code.
          </p>
          <p>
            {@feature.summary}
          </p>
          <p>
            <a href={@feature.official}>Official reference</a>
          </p>
        </div>
      <% end %>
    </Layouts.catalog>
    """
  end

  defp pad(number), do: number |> Integer.to_string() |> String.pad_leading(2, "0")
end
