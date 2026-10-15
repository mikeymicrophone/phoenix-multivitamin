# Discoveries

Non-obvious Phoenix behaviors found while bottling this catalog. Every entry
was confirmed by a test in this repository against **Phoenix 1.8.15** and
**LiveView 1.2**. Nothing is written here from the guides alone, and nothing
is written here until a test has shown it.

Each entry has a short title, what happens, why it matters, what to do about
it, and a link to the scenario that shows it.

## Routing and plugs

### assign_new copies a pipeline assign only on the disconnected render

**What happens.** A router pipeline plug assigns `:shift` onto the conn.
The controller tape prints it. A LiveView `assign_new(:shift, fn -> "no
shift from the plug" end)` copies that assign on a disconnected `get/2` of
the silo. `socket.assigns` did not already have `:shift`. After `live/2`,
the connected mount runs the fallback. The graveyard shift is gone.

**Why it matters.** Loading a current user, a watch, or a ticket in a
pipeline plug and then `assign_new/3` in the LiveView looks shared. It is
shared only for the static HTML. The LiveView process starts without the
conn and without that assign.

**What to do.** Put shared auth in the session, or load it again in
`mount/3` when `connected?(socket)` is true. Do not treat a pipeline
assign as a socket assign.

**Seen in:** [Kalama elevator tape](features/01-routing-and-plugs/06-kalama-elevator-tape/).

### plug_init_mode :runtime re-runs init/1 on every request in test

**What happens.** `plug BallardLockPlug, chambers: 2` still turns the
keyword list into a map in `init/1`. This app sets
`config :phoenix, :plug_init_mode, :runtime` in `config/test.exs`. Two
GETs therefore get two different `init/1` timestamps. `Phoenix.plug_init_mode/0`
is `:runtime`. Production defaults to `:compile`.

**Why it matters.** Guides talk about `init/1` as compile-time. Under
`mix test` and `mix phx.server` here, it is per request. A test that
expected one captured timestamp fails. Code that reads `Application.get_env`
in `init/1` will see live config in test and a frozen snapshot in prod.

**What to do.** Keep `init/1` a pure transform of options. Read runtime
config in `call/2`. Do not assert uniqueness of `init/1` in tests unless
you set `:plug_init_mode` to `:compile`.

**Seen in:** [Ballard lock house](features/01-routing-and-plugs/10-ballard-lock-house/).

### redirect/2 without halt/1 still runs the action

**What happens.** `Phoenix.Controller.redirect/2` sends the 302 body.
Without `halt/1`, the next plug — the action — still runs. The leaky chart
desk then renders and raises `Plug.Conn.AlreadySentError`. The halted desk
never assigns `:charts_opened`.

**Why it matters.** A session plug that "just redirects" looks finished.
The action still opens the drawer and then crashes trying to send a second
response.

**What to do.** Pipe `halt()` after `redirect/2` in a plug. Do not rely on
the redirect having sent.

**Seen in:** [Quillayute chart desk](features/01-routing-and-plugs/11-quillayute-chart-desk/).

## Verified routes

### A nil query value encodes as an empty `key=`, it is not omitted

**What happens.** `~p"/gate?#{[]}"` and `~p"/gate?#{%{}}"` drop the `?`
entirely. `~p"/gate?#{[crew: nil, tide: "ebb"]}"` does not drop `crew`.
It becomes `?crew=&tide=ebb`. `handle_params/3` then sees `"crew" => ""`.
`false` encodes as `"false"`.

**Why it matters.** Passing `nil` looks like "leave this optional key
off". The key is still there, and `value || "none"` will not treat `""`
as missing because an empty string is truthy.

**What to do.** Omit the key from the keyword list or map. Do not pass
`nil` if you wanted the key gone.

**Seen in:** [Point No Point staff gate](features/02-verified-routes/07-point-no-point-staff-gate/).

### `url(~p)` uses the endpoint `url:` config, including a default port 4000

**What happens.** `config :phoenix_multivitamin, Endpoint, url: [host: "localhost"]`
has no port. `url(~p"/path")` still emits `http://localhost:4000/path`.
The test listener is `http: [port: 4002]` and does not appear. A `%URI{}`
or `put_router_url/2` is what changes the host.

**Why it matters.** A mailer or an `assert` that expected `http://localhost/path`
or `:4002` fails. The generated URL is not the listener the test conn talks to.

**What to do.** Compare against `Endpoint.url() <> path`, or pass a `%URI{}`
/`put_router_url/2` when the public host must differ.

**Seen in:** [Smith Island tide drum](features/02-verified-routes/08-smith-island-tide-drum/),
[Point Robinson bell relay](features/02-verified-routes/09-point-robinson-bell-relay/).

### A static `~p` never asks the router, and never checks that the file exists

**What happens.** `statics: ~w(assets fonts images favicon.ico robots.txt)`
makes any path whose first segment matches that list call
`Endpoint.static_path/1`. `~p"/images/missing-characteristic.svg"` compiles
with no `no route path` warning. `static_integrity/2` is `nil` until
`mix phx.digest`.

**Why it matters.** A typo in a plate filename looks verified. The 404
is a runtime miss, not a compile warning.

**What to do.** Treat static `~p` as a prefix check. Assert the file is
served, or keep names in one helper.

**Seen in:** [Turn Point light book](features/02-verified-routes/04-turn-point-light-book/).

### A list of binaries in one interpolation becomes extra path segments

**What happens.** `~p"/watches/#{watch}"` with a `%PatosIslandWatch{}` is
one segment. The same sigil with `["dawn", "dusk"]` becomes
`/watches/dawn/dusk`. Compile-time verification substitutes `"1"` for the
interpolation, so it still matches `/watches/:watch`. A slash inside a
binary is `%2F`, not a new segment.

**Why it matters.** A watch list interpolated "to be helpful" compiles
clean and 404s at runtime. The extra segment was never in the router.

**What to do.** Interpolate one `Phoenix.Param` value per dynamic segment.
Do not pass a list unless you mean extra segments.

**Seen in:** [Patos Island fog logger](features/02-verified-routes/03-patos-island-fog-logger/),
[Deception Pass fault line](features/02-verified-routes/12-deception-pass-fault-line/).

### `/features/#{a}/#{b}` does not warn: the stand-in matches the planned catch-all

**What happens.** Verification replaces interpolations with `"1"`.
`~p"/features/#{feature}/#{span}"` is checked as `/features/1/1`, which
matches `live "/features/:feature/:example"`. A retired nested path such
as `/features/02-verified-routes/12-deception-pass-fault-line/collapsed-span`
hidden behind those two dynamics does not warn. A path with enough static
segments (`~p"/features/02-verified-routes/12-deception-pass-fault-line/collapsed-span"`)
does: `no route path ... matches "/.../collapsed-span"`.

**Why it matters.** The docs' "dynamic segments skip the warning" is easy
to read as "dynamics are never checked". They are checked, against the
stand-in. A catch-all two segments under `/features` makes a whole family
of paths look verified.

**What to do.** Keep a static prefix long enough to miss the catch-all
when the extra folder is gone. Compile a throwaway module in the test if
you need to show the warning; `mix precommit` treats warnings as errors.

**Seen in:** [Deception Pass fault line](features/02-verified-routes/12-deception-pass-fault-line/).

## Function components and HEEx

### Passing nil does not restore an attr default

**What happens.** `attr :grams, :integer, default: 3` fills grams when the
caller omits the attr. Passing `grams={nil}` writes `nil` onto the assigns
map. The lima packet then reads "scale empty", not "3 g".
`Map.merge(defaults, assigns)` lets an explicit nil win.

**Why it matters.** Clearing a field with `nil` looks like "use the default"
and instead blanks the packet.

**What to do.** Omit the attr, or pass the default value again. Do not pass
nil if you wanted the default.

**Seen in:** [Seed packet label press](features/04-function-components-and-heex/01-seed-packet-label-press/).

### A caller class replaces the global rest default class

**What happens.** `attr :rest, :global, default: %{class: "mill-ticket"}`
applies `mill-ticket` only when the caller omits `class`. Passing
`class="rush-load"` replaces that default. The two names are not
concatenated. Writing `class="scale-slip"` on the same tag as `{@rest}`
emits a second class attribute; the HTML parser keeps the first, so the
cedar ticket shows `scale-slip` and never `mill-ticket`.

**Why it matters.** The docs say the default map is "merged". Map merge
replaces the `class` key. A static class on the same tag hides the rest
class entirely.

**What to do.** Put the class on rest, not also on the tag. Concatenate
caller and default classes yourself if you need both names.

**Seen in:** [Port Angeles mill tickets](features/04-function-components-and-heex/05-port-angeles-mill-tickets/).

### Map.put on component assigns freezes that key after the first render

**What happens.** Inside a function component, `Map.put(assigns, :fired_pass, ...)`
updates the Elixir map but does not mark `__changed__`. `{@fired_pass}`
keeps the first pass even while `{@kiln_temp}` updates.
`Phoenix.Component.assign/3` marks the key, so the assign chip's pass
moves. A quiet chip that was never passed `kiln_temp` does not recompute
its pass when only the kiln changes.

**Why it matters.** A firing pass, timestamp, or generated id written with
`Map.put/3` looks live in the first paint and then never moves.

**What to do.** Use `assign/3`, `assign_new/3`, or `update/3` inside
function components, never `Map.put/3`, if the template should see later
values.

**Seen in:** [Discovery Bay tile board](features/04-function-components-and-heex/09-discovery-bay-tile-board/).

### values: does not reject a dynamic assign at runtime

**What happens.** `attr :species, :atom, values: [:chinook, :coho, :steelhead]`
warns at compile time for a literal outside the list. `species={@species}`
with `@species == :chum` still renders. A direct `incubation_tray/1` call
missing `:species` raises `KeyError` from `@species`, not an
`ArgumentError` from `attr/3`. Defaults still apply on that direct call.

**Why it matters.** `values:` looks like a guard. A hatchery load from a
form or assign will print an unlisted species without a warning.

**What to do.** Do not treat `values:` as a runtime guard. Check the assign
in Elixir if the tray must refuse an unlisted species.

**Seen in:** [Elwha hatchery trays](features/04-function-components-and-heex/11-elwha-hatchery-trays/).

### Seeding to_form/2 with the field value makes used_input?/1 true

**What happens.** `used_input?/1` is true when the field is present in form
params without an `_unused_` sibling. `to_form(%{"ranger" => "Thea"}, as: :permit)`
therefore reports the ranger field as used on first paint, before anyone
typed. Starting from `to_form(%{}, as: :permit)` keeps it untouched until
`phx-change` sends the field.

**Why it matters.** Prefilling the ranger name to show a default also
unlocks "used" errors and copy on first paint.

**What to do.** Seed `to_form/2` with an empty params map if you need the
untouched state. Put the displayed name in a separate assign.

**Seen in:** [Kaleetan trail permits](features/04-function-components-and-heex/10-kaleetan-trail-permits/).

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
