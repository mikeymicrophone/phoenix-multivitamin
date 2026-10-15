defmodule PhoenixMultivitaminWeb.CatalogLive do
  @moduledoc """
  The bottle index: every feature and every slot, with no scenario copy of its
  own. Titles come from each feature's `feature.exs`.
  """
  use PhoenixMultivitaminWeb, :live_view

  alias PhoenixMultivitamin.Catalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Phoenix Multivitamin")
     |> assign(:features, Catalog.features())
     |> assign(:bottled_count, Catalog.bottled_count())
     |> assign(:slot_count, Catalog.slot_count())
     |> assign(:feature_count, Catalog.feature_count())
     |> assign(:phoenix_vsn, Application.spec(:phoenix, :vsn))
     |> assign(:live_view_vsn, Application.spec(:phoenix_live_view, :vsn))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <header class="masthead">
        <p class="breadcrumbs">A catalog of Phoenix</p>
        <h1>Phoenix Multivitamin</h1>
        <p class="lede">
          Thirteen samples of healthy code for each feature of the
          <a href="https://www.phoenixframework.org">Phoenix</a>
          web framework. Every scenario is a realistic job of work with real names:
          no placeholder controllers, no counters that only count.
        </p>
      </header>

      <aside class="supplement-facts" aria-labelledby="supplement-facts-heading">
        <h2 id="supplement-facts-heading">Supplement Facts</h2>
        <dl>
          <dt>Serving size</dt>
          <dd>1 scenario</dd>
          <dt>Servings per feature</dt>
          <dd>13</dd>
          <dt>Features</dt>
          <dd>{@feature_count}</dd>
          <dt>Scenarios</dt>
          <dd>{@slot_count}</dd>
          <dt>Bottled</dt>
          <dd>{@bottled_count} of {@slot_count}</dd>
          <dt>Active ingredient</dt>
          <dd>Phoenix {@phoenix_vsn}</dd>
          <dt>LiveView</dt>
          <dd>{@live_view_vsn}</dd>
          <dt>Database</dt>
          <dd>SQLite</dd>
        </dl>
      </aside>

      <p>
        {@bottled_count} of {@slot_count} scenarios are bottled. Non-obvious Phoenix
        behaviors, confirmed by a test in this repository, live in <a href="https://github.com/mikeymicrophone/phoenix-multivitamin/blob/main/DISCOVERIES.md">DISCOVERIES.md</a>.
      </p>

      <h2>Features</h2>
      <ul class="feature-shelf">
        <li :for={feature <- @features} class="feature-bottle">
          <span class="dose-count">
            {Enum.count(feature.slots, & &1.bottled)} of 13 bottled
          </span>
          <h3>
            {pad(feature.number)} · {feature.title}
          </h3>
          <p>{feature.summary}</p>
          <p>
            <a href={feature.official}>Reference</a>
            ·
            <a href={"https://github.com/mikeymicrophone/phoenix-multivitamin/tree/main/features/#{feature.slug}"}>
              Folder
            </a>
          </p>
          <ol>
            <li :for={slot <- feature.slots} class={if(slot.bottled, do: nil, else: "planned")}>
              <%= if slot.bottled do %>
                <.link navigate={slot.path}>{slot.title}</.link>
              <% else %>
                <.link navigate={slot.path} class="planned">{slot.title}</.link>
                <span class="muted"> — planned</span>
              <% end %>
            </li>
          </ol>
        </li>
      </ul>
    </Layouts.catalog>
    """
  end

  defp pad(number), do: number |> Integer.to_string() |> String.pad_leading(2, "0")
end
