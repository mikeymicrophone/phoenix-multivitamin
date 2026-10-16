defmodule PhoenixMultivitaminWeb.ParoInboundLogHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 04 · Paro inbound log
      </p>

      <h1>Paro inbound log</h1>
      <p class="lede">
        Clerk {@clerk} posts A319s at {@station}. This board lives in a
        forwarded router that only sees the path after <code>/valley</code>.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
        <dt>Craft</dt>
        <dd id="craft-name">{@craft}</dd>
        <dt>Reg</dt>
        <dd id="reg-name">{@reg || "the valley fleet"}</dd>
        <dt>Request path</dt>
        <dd id="request-path">{@request_path}</dd>
        <dt>Script name</dt>
        <dd id="script-name">{@script_name}</dd>
        <dt>Path info</dt>
        <dd id="path-info">{@path_info}</dd>
      </dl>

      <div class="watch-switcher">
        <a
          id="open-druk"
          href="/features/01-routing-and-plugs/04-paro-inbound-log/valley/a319/druk"
        >
          Log the Drukair A319
        </a>
      </div>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/04-paro-inbound-log"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
