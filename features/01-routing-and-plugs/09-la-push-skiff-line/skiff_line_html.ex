defmodule PhoenixMultivitaminWeb.LaPushSkiffLineHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 09 · La Push skiff line
      </p>

      <h1>La Push skiff line</h1>
      <p class="lede">
        Skipper {@skipper} holds {@skiff} off {@beach}. The beach, skiff, and
        skipper are assigns, so this board can print them. The launch code
        stayed in <code>conn.private</code> until the controller copied it.
      </p>

      <dl class="station-meta">
        <dt>Beach</dt>
        <dd id="beach-name">{@beach}</dd>
        <dt>Skiff</dt>
        <dd id="skiff-name">{@skiff}</dd>
        <dt>Skipper</dt>
        <dd id="skipper-name">{@skipper}</dd>
        <dt>Launch code from assigns</dt>
        <dd id="launch-code-assign">{@launch_code_assign || "not on assigns"}</dd>
        <dt>Launch code from private</dt>
        <dd id="launch-code-private">{@launch_code_private}</dd>
        <dt>Radio</dt>
        <dd id="radio-channel">{@radio_channel_private}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/09-la-push-skiff-line"}>Beach map</.link>
      </p>
    </Layouts.catalog>
    """
  end
end
