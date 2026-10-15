# Discoveries

Non-obvious Phoenix behaviors found while bottling this catalog. Every entry
was confirmed by a test in this repository against **Phoenix 1.8.15** and
**LiveView 1.2**. Nothing is written here from the guides alone, and nothing
is written here until a test has shown it.

Each entry has a short title, what happens, why it matters, what to do about
it, and a link to the scenario that shows it.

## LiveView lifecycle and events

### The disconnected render does not spawn a LiveView process

**What happens.** `get/2` runs `mount/3` and `handle_params/3` inside the
HTTP request. `Phoenix.LiveView.Static.render/3` never starts a LiveView
server. `terminate/2` does not run, even if the LiveView defines it. A
departure desk that records `terminate/2` stays empty after a static GET.

**Why it matters.** Cleanup, unsubscribes, and "who left the board" logs
tied to `terminate/2` only see connected sockets. Counting mounts in
`terminate/2` undercounts the static render.

**What to do.** Treat the disconnected render as a pure function. Arm
clocks, subscribe, and trap exits only when `connected?/1` is true. Put
leave-side effects in `terminate/2` of the connected process.

**Seen in:** [Admiralty Inlet night board](features/06-liveview-lifecycle-and-events/13-admiralty-inlet-night-board/).

### `on_mount` runs twice for `live/2`, once for `get/2`

**What happens.** `on_mount` runs before `mount/3` on the static HTTP
render and again on the connected mount. Those are different processes. A
booth counter incremented in `on_mount` reads 1 after `get/2` and 2 after
`live/2`. Assigns set in `on_mount` are already on the socket when
`mount/3` runs.

**Why it matters.** Starting a timer, opening a port, or incrementing a
global in `on_mount` without checking `connected?/1` doubles up as soon as
a browser connects.

**What to do.** Keep `on_mount` idempotent per process. Share state across
the static and connected mounts only through an external process, and only
when you mean to count both.

**Seen in:** [Lime Kiln hydrophone watch](features/06-liveview-lifecycle-and-events/12-lime-kiln-hydrophone-watch/).

### `send(self())` from `handle_event/3` is applied after that event's render

**What happens.** `send(self(), :strike_bell)` inside `handle_event/3`
queues `handle_info/2` as the next mailbox message. `render_click/1`
returns the HTML from the event callback. That HTML does not yet include
the strike. `:sys.get_state/1` waits until the LiveView is idle; then the
tally is 1.

**Why it matters.** Code that `send(self(), ...)` to "load after paint"
looks broken in a test that only asserts on the `render_click/1` return
value. The follow-up did run; the test sampled too early.

**What to do.** Assert on the event HTML for the click itself. Flush with
`:sys.get_state/1` (or a later `render/1`) before asserting on
`handle_info/2` assigns.

**Seen in:** [Slip Point bell book](features/06-liveview-lifecycle-and-events/09-slip-point-bell-book/).

### `temporary_assigns` reset the socket, not the last DOM node

**What happens.** A `last_sighting` listed in `temporary_assigns` appears
in the HTML returned by `render_click/1`. After that render, the assign is
reset to the mount value (`nil`) and is not marked changed, so LiveView
does not patch `#last-sighting`. A later event that reads the assign sees
`nil` ("cleared") while the old sighting stays on the page. A ferry wake
that never touches `last_sighting` leaves that node in place. A regular
assign (`posted_bearings`) keeps every line and does patch.

**Why it matters.** The page still shows a sighting the socket has already
forgotten. Accumulating into a temporary assign loses the prefix. Clearing
the node requires assigning that key again.

**What to do.** Put values you must keep in a regular assign. Use
`temporary_assigns` only for payloads that are safe to forget after the
diff goes out, and re-assign the key when the DOM must change.

**Seen in:** [Cattle Point range log](features/06-liveview-lifecycle-and-events/10-cattle-point-range-log/).

### `push_event/3` from the disconnected render is discarded

**What happens.** `mount/3` calls `push_event(socket, "arm_horn", %{connected: connected?(socket), ...})` on both renders. After `live/2`,
`assert_push_event` receives one payload, with `connected: true`. The
static payload with `connected: false` never arrives. There is no channel
during `Phoenix.LiveView.Static.render/3`, and the connected mount is a
new socket.

**Why it matters.** A chart, canvas, or horn console that arms itself from
a mount-time push must push again on the connected mount, or the client
hook never sees it.

**What to do.** Push from the connected mount (`if connected?(socket) do`),
or push again from an event the hook sends after `mounted()`.

**Seen in:** [Marrowstone horn events](features/06-liveview-lifecycle-and-events/11-marrowstone-horn-events/).

### `phx-value-*` payloads are always strings

**What happens.** `phx-value-period="15"` and `phx-value-blasts="2"` arrive
in `handle_event/3` as `"15"` and `"2"`. `is_binary(period)` is true. A
click with no `phx-value-*` still fires, with an empty map.

**Why it matters.** `period + 1` and `period == 15` both fail. The card
has to parse, and it has to accept `nil` when the silence button sends
nothing.

**What to do.** Parse in `handle_event/3`. Do not pattern-match integers
out of `phx-value-*`.

**Seen in:** [Point Wilson fog signal card](features/06-liveview-lifecycle-and-events/02-point-wilson-fog-signal-card/).

### `phx-key` is a client filter; LiveViewTest does not apply it

**What happens.** The browser compares `phx-key` to `event.key`
case-insensitively and drops a mismatch. `render_keydown/2` does not. A
fog pad with `phx-key="f"` still receives `%{"key" => "x"}` from
LiveViewTest, and `handle_event/3` runs.

**Why it matters.** A round that trusts `phx-key` will post fog when a
test (or a crafted client) sends another key. The filter is not a server
guard.

**What to do.** Pattern-match `"key"` in `handle_event/3` if the action
must only run for that key. Use `phx-key` for the browser, not for
security.

**Seen in:** [Tatoosh weather round](features/06-liveview-lifecycle-and-events/06-tatoosh-weather-round/).

### `phx-debounce` and `phx-throttle` are client-side; LiveViewTest does not wait

**What happens.** `phx-debounce="500"`, `phx-debounce="blur"`, and
`phx-throttle="2000"` stay in the markup. `render_change/2` posts radio
copy immediately. Two `render_click/1` calls a millisecond apart both
increment the current table.

**Why it matters.** A test cannot prove the delay. It can prove the
attribute is present and that the server handles the event when it
arrives. A test that expected "only one click per two seconds" will fail
under LiveViewTest even when the browser throttles.

**What to do.** Assert the attribute and the server-side result. Do not
assert timing in `Phoenix.LiveViewTest`. Time the browser if the delay is
the behavior that matters.

**Seen in:** [Destruction Island relief board](features/06-liveview-lifecycle-and-events/07-destruction-island-relief-board/),
[Ediz Hook current table](features/06-liveview-lifecycle-and-events/08-ediz-hook-current-table/).

### `phx-submit` does not send `_target`

**What happens.** `phx-change` params include `"_target"` naming the field
that moved. `phx-submit` params on the same form do not. A harbormaster
slate that records `had_target?` from `Map.has_key?(params, "_target")`
reads yes on change and no on submit.

**Why it matters.** Code that always pattern-matches `"_target"` will fail
to compile a match on submit, or will skip the assign-berth clause.

**What to do.** Use different event names for change and submit. Read
`_target` only in the change callback.

**Seen in:** [Friday Harbor berth slate](features/06-liveview-lifecycle-and-events/04-friday-harbor-berth-slate/),
[Cape Disappointment lamp round](features/06-liveview-lifecycle-and-events/03-cape-disappointment-lamp-round/).
