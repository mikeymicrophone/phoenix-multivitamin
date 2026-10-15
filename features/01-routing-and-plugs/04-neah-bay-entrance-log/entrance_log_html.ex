defmodule PhoenixMultivitaminWeb.NeahBayEntranceLogHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 04 · Neah Bay entrance log
      </p>

      <h1>Neah Bay entrance log</h1>
      <p class="lede">
        Recorder {@recorder} posts canoes at {@station}. This board lives in a
        forwarded router that only sees the path after <code>/entrance</code>.
      </p>

      <dl class="station-meta">
        <dt>Station</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Recorder</dt>
        <dd id="recorder-name">{@recorder}</dd>
        <dt>Canoe</dt>
        <dd id="canoe-name">{@canoe}</dd>
        <dt>Hull</dt>
        <dd id="hull-name">{@hull || "the village fleet"}</dd>
        <dt>Request path</dt>
        <dd id="request-path">{@request_path}</dd>
        <dt>Script name</dt>
        <dd id="script-name">{@script_name}</dd>
        <dt>Path info</dt>
        <dd id="path-info">{@path_info}</dd>
      </dl>

      <div class="watch-switcher">
        <a
          id="open-whaler"
          href="/features/01-routing-and-plugs/04-neah-bay-entrance-log/entrance/canoe/whaler"
        >
          Log the whaler
        </a>
      </div>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/04-neah-bay-entrance-log"}>
          Station map
        </.link>
      </p>
    </Layouts.catalog>
    """
  end
end
