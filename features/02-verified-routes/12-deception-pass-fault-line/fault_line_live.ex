# Verified routes · 12 · Deception Pass fault line
#
# Teaches:
# - A ~p whose static segments do not match the router warns after compile
# - Verification runs in @after_verify, as "no route path for Router matches ~p"
# - Fully dynamic interpolations can skip that check (the "1" stand-in still might match)
# - mix precommit compiles with --warnings-as-errors, so retired paths cannot stay in lib/

defmodule PhoenixMultivitaminWeb.DeceptionPassFaultLineLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Deception Pass fault line")
     |> assign(:station, "Deception Pass Bridge")
     |> assign(:engineer, "Quill")
     |> assign(:span_path, current_span_path())
     |> assign(:warning_copy, warning_example())}
  end

  def current_span_path, do: ~p"/features/02-verified-routes/12-deception-pass-fault-line"

  def warning_example do
    ~s|warning: no route path for PhoenixMultivitaminWeb.Router matches ~p"/features/02-verified-routes/12-deception-pass-fault-line/collapsed-span"|
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · Verified routes · 12 · Deception Pass fault line
      </p>

      <h1>Deception Pass fault line</h1>
      <p class="lede">
        Engineer {@engineer} reads the steel at the {@station}. The current
        span is a verified ~p. The collapsed-span path was pulled from the
        router; compiling it now warns. That warning is captured in the test,
        not left in this module — mix precommit treats warnings as errors.
      </p>

      <dl class="station-meta">
        <dt>Crossing</dt>
        <dd id="station-name">{@station}</dd>
        <dt>Engineer</dt>
        <dd id="engineer-name">{@engineer}</dd>
        <dt>Current span</dt>
        <dd id="span-path">{@span_path}</dd>
      </dl>

      <div class="scenario">
        <h2>Retired span</h2>
        <p id="warning-copy">{@warning_copy}</p>
        <p id="span-copy">
          The current span still verifies. The collapsed span is only compiled
          inside the test module that expects the warning.
        </p>
      </div>
    </Layouts.catalog>
    """
  end
end
