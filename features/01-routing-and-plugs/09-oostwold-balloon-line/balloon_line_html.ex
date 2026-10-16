defmodule PhoenixMultivitaminWeb.OostwoldBalloonLineHTML do
  @moduledoc false
  use PhoenixMultivitaminWeb, :html

  def show(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Routing and plugs · 09 · Oostwold balloon line
      </p>

      <h1>Oostwold balloon line</h1>
      <p class="lede">
        Crew chief {@crew_chief} holds {@balloon} off {@field}. The field, balloon, and
        crew chief are assigns, so this board can print them. The launch code
        stayed in <code>conn.private</code> until the controller copied it.
      </p>

      <dl class="station-meta">
        <dt>Field</dt>
        <dd id="field-name">{@field}</dd>
        <dt>Balloon</dt>
        <dd id="balloon-name">{@balloon}</dd>
        <dt>Crew chief</dt>
        <dd id="crew-chief-name">{@crew_chief}</dd>
        <dt>Launch code from assigns</dt>
        <dd id="launch-code-assign">{@launch_code_assign || "not on assigns"}</dd>
        <dt>Launch code from private</dt>
        <dd id="launch-code-private">{@launch_code_private}</dd>
        <dt>Radio</dt>
        <dd id="radio-channel">{@radio_channel_private}</dd>
      </dl>

      <p class="breadcrumbs">
        <.link navigate={~p"/features/01-routing-and-plugs/09-oostwold-balloon-line"}>Field map</.link>
      </p>
    </Layouts.catalog>
    """
  end
end
