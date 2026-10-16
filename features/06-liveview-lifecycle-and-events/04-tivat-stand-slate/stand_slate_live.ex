# LiveView lifecycle and events · 04 · Tivat stand slate
#
# Teaches:
# - phx-change validates as the clerk types, without posting the stand
# - phx-submit posts the assignment and is a different event name
# - Submit params do not include "_target"
# - A type="submit" button inside the form fires phx-submit, not a click

defmodule PhoenixMultivitaminWeb.TivatStandSlateLive do
  @moduledoc false
  use PhoenixMultivitaminWeb, :live_view

  @stands ~w(A-12 B-3 Customs-apron)

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Tivat stand slate")
     |> assign(:field, "Tivat")
     |> assign(:clerk, "Ivana")
     |> assign(:tail, "")
     |> assign(:stand, "A-12")
     |> assign(:preview, nil)
     |> assign(:error, nil)
     |> assign(:last_event, nil)
     |> assign(:had_target?, false)
     |> assign(:posted_stands, [])}
  end

  @impl true
  def handle_event("preview_stand", params, socket) do
    %{"slate" => %{"tail" => tail, "stand" => stand}} = params
    error = stand_error(tail, stand, socket.assigns.posted_stands)

    {:noreply,
     socket
     |> assign(:tail, tail)
     |> assign(:stand, stand)
     |> assign(:error, error)
     |> assign(:preview, preview_line(tail, stand, error))
     |> assign(:last_event, "preview_stand")
     |> assign(:had_target?, Map.has_key?(params, "_target"))}
  end

  def handle_event("assign_stand", params, socket) do
    %{"slate" => %{"tail" => tail, "stand" => stand}} = params
    error = stand_error(tail, stand, socket.assigns.posted_stands)

    socket =
      socket
      |> assign(:tail, tail)
      |> assign(:stand, stand)
      |> assign(:last_event, "assign_stand")
      |> assign(:had_target?, Map.has_key?(params, "_target"))

    if error do
      {:noreply,
       assign(socket, :error, error) |> assign(:preview, preview_line(tail, stand, error))}
    else
      posted = %{
        id: "stand-#{System.unique_integer([:positive])}",
        tail: tail,
        stand: stand
      }

      {:noreply,
       socket
       |> assign(:error, nil)
       |> assign(:preview, nil)
       |> assign(:tail, "")
       |> assign(:posted_stands, [posted | socket.assigns.posted_stands])}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.catalog flash={@flash}>
      <p class="breadcrumbs">
        <.link navigate={~p"/"}>Catalog</.link> · LiveView lifecycle and events
        · 04 · Tivat stand slate
      </p>

      <h1>Tivat stand slate</h1>
      <p class="lede">
        Clerk {@clerk} assigns the Global 6000 and visiting tails at {@field}. <code>phx-change</code>
        previews the stand. <code>phx-submit</code>
        posts it. Submit does not send <code>_target</code>.
      </p>

      <dl class="station-meta">
        <dt>Field</dt>
        <dd id="field-name">{@field}</dd>
        <dt>Clerk</dt>
        <dd id="clerk-name">{@clerk}</dd>
        <dt>Last event</dt>
        <dd id="last-event">{@last_event || "none"}</dd>
        <dt>Had _target</dt>
        <dd id="had-target">{if @had_target?, do: "yes", else: "no"}</dd>
        <dt>Preview</dt>
        <dd id="stand-preview">{@preview || "none"}</dd>
      </dl>

      <form id="stand-slate-form" phx-change="preview_stand" phx-submit="assign_stand">
        <label>
          Tail
          <input
            id="tail-name"
            type="text"
            name="slate[tail]"
            value={@tail}
            placeholder="9H-TIV"
          />
        </label>
        <label>
          Stand
          <select id="stand-select" name="slate[stand]">
            <option :for={stand <- stands()} value={stand} selected={stand == @stand}>{stand}</option>
          </select>
        </label>
        <p :if={@error} id="stand-error">{@error}</p>
        <div class="watch-actions">
          <button id="post-stand" type="submit">Post stand</button>
        </div>
      </form>

      <div class="scenario">
        <h2>Posted slate</h2>
        <p :if={@posted_stands == []} id="empty-slate" class="muted">
          No stands posted this shift.
        </p>
        <ol id="posted-stands" class="watch-log">
          <li :for={posted <- @posted_stands} id={posted.id}>
            {posted.tail} at {posted.stand}
          </li>
        </ol>
      </div>
    </Layouts.catalog>
    """
  end

  defp stands, do: @stands

  defp stand_error(tail, stand, posted) do
    cond do
      String.trim(tail) == "" ->
        "Name the tail before posting"

      String.length(String.trim(tail)) < 3 ->
        "Tail name is too short for the slate"

      Enum.any?(posted, &(&1.stand == stand)) ->
        "#{stand} already holds #{Enum.find(posted, &(&1.stand == stand)).tail}"

      true ->
        nil
    end
  end

  defp preview_line(_tail, _stand, error) when is_binary(error), do: error
  defp preview_line(tail, stand, _error), do: "#{tail} standing by for #{stand}"
end
