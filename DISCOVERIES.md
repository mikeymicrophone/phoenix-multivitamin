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
the hydrant. `socket.assigns` did not already have `:shift`. After `live/2`,
the connected mount runs the fallback. The graveyard shift is gone.

**Why it matters.** Loading a current user, a watch, or a ticket in a
pipeline plug and then `assign_new/3` in the LiveView looks shared. It is
shared only for the static HTML. The LiveView process starts without the
conn and without that assign.

**What to do.** Put shared auth in the session, or load it again in
`mount/3` when `connected?(socket)` is true. Do not treat a pipeline
assign as a socket assign.

**Seen in:** [Changi hydrant tape](features/01-routing-and-plugs/06-changi-hydrant-tape/).

### plug_init_mode :runtime re-runs init/1 on every request in test

**What happens.** `plug KirunaDeicePlug, pads: 2` still turns the
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

**Seen in:** [Kiruna de-ice pad](features/01-routing-and-plugs/10-kiruna-deice-pad/).

### redirect/2 without halt/1 still runs the action

**What happens.** `Phoenix.Controller.redirect/2` sends the 302 body.
Without `halt/1`, the next plug — the action — still runs. The leaky briefing
desk then renders and raises `Plug.Conn.AlreadySentError`. The halted desk
never assigns `:plates_opened`.

**Why it matters.** A session plug that "just redirects" looks finished.
The action still opens the drawer and then crashes trying to send a second
response.

**What to do.** Pipe `halt()` after `redirect/2` in a plug. Do not rely on
the redirect having sent.

**Seen in:** [Bergen briefing desk](features/01-routing-and-plugs/11-bergen-briefing-desk/).

## Verified routes

### A nil query value encodes as an empty `key=`, it is not omitted

**What happens.** `~p"/gate?#{[]}"` and `~p"/gate?#{%{}}"` drop the `?`
entirely. `~p"/gate?#{[crew: nil, qnh: "1013"]}"` does not drop `crew`.
It becomes `?crew=&qnh=1013`. `handle_params/3` then sees `"crew" => ""`.
`false` encodes as `"false"`.

**Why it matters.** Passing `nil` looks like "leave this optional key
off". The key is still there, and `value || "none"` will not treat `""`
as missing because an empty string is truthy.

**What to do.** Omit the key from the keyword list or map. Do not pass
`nil` if you wanted the key gone.

**Seen in:** [Gibraltar staff gate](features/02-verified-routes/07-gibraltar-staff-gate/).

### `url(~p)` uses the endpoint `url:` config, including a default port 4000

**What happens.** `config :phoenix_multivitamin, Endpoint, url: [host: "localhost"]`
has no port. `url(~p"/path")` still emits `http://localhost:4000/path`.
The test listener is `http: [port: 4002]` and does not appear. A `%URI{}`
or `put_router_url/2` is what changes the host.

**Why it matters.** A mailer or an `assert` that expected `http://localhost/path`
or `:4002` fails. The generated URL is not the listener the test conn talks to.

**What to do.** Compare against `Endpoint.url() <> path`, or pass a `%URI{}`
/`put_router_url/2` when the public host must differ.

**Seen in:** [Mataveri METAR drum](features/02-verified-routes/08-mataveri-metar-drum/),
[Accra slot relay](features/02-verified-routes/09-accra-slot-relay/).

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

**Seen in:** [Le Bourget light book](features/02-verified-routes/04-le-bourget-light-book/).

### A list of binaries in one interpolation becomes extra path segments

**What happens.** `~p"/watches/#{watch}"` with a `%IlulissatIceWatch{}` is
one segment. The same sigil with `["dawn", "dusk"]` becomes
`/watches/dawn/dusk`. Compile-time verification substitutes `"1"` for the
interpolation, so it still matches `/watches/:watch`. A slash inside a
binary is `%2F`, not a new segment.

**Why it matters.** A watch list interpolated "to be helpful" compiles
clean and 404s at runtime. The extra segment was never in the router.

**What to do.** Interpolate one `Phoenix.Param` value per dynamic segment.
Do not pass a list unless you mean extra segments.

**Seen in:** [Ilulissat ice logger](features/02-verified-routes/03-ilulissat-ice-logger/),
[Sion alpine fault line](features/02-verified-routes/12-sion-alpine-fault-line/).

### `/features/#{a}/#{b}` does not warn: the stand-in matches the planned catch-all

**What happens.** Verification replaces interpolations with `"1"`.
`~p"/features/#{feature}/#{span}"` is checked as `/features/1/1`, which
matches `live "/features/:feature/:example"`. A retired nested path such
as `/features/02-verified-routes/12-sion-alpine-fault-line/collapsed-ridge`
hidden behind those two dynamics does not warn. A path with enough static
segments (`~p"/features/02-verified-routes/12-sion-alpine-fault-line/collapsed-ridge"`)
does: `no route path ... matches "/.../collapsed-ridge"`.

**Why it matters.** The docs' "dynamic segments skip the warning" is easy
to read as "dynamics are never checked". They are checked, against the
stand-in. A catch-all two segments under `/features` makes a whole family
of paths look verified.

**What to do.** Keep a static prefix long enough to miss the catch-all
when the extra folder is gone. Compile a throwaway module in the test if
you need to show the warning; `mix precommit` treats warnings as errors.

**Seen in:** [Sion alpine fault line](features/02-verified-routes/12-sion-alpine-fault-line/).

## Function components and HEEx

### Passing nil does not restore an attr default

**What happens.** `attr :puff_count, :integer, default: 3` fills puffs when the
caller omits the attr. Passing `puff_count={nil}` writes `nil` onto the assigns
map. The prototype plate then reads "whistle silent", not "3".
`Map.merge(defaults, assigns)` lets an explicit nil win.

**Why it matters.** Clearing a field with `nil` looks like "use the default"
and instead blanks the plate.

**What to do.** Omit the attr, or pass the default value again. Do not pass
nil if you wanted the default.

**Seen in:** [Payerne Roadster flight plate](features/04-function-components-and-heex/01-payerne-roadster-flight-plate/).

### A caller class replaces the global rest default class

**What happens.** `attr :rest, :global, default: %{class: "join-ticket"}`
applies `join-ticket` only when the caller omits `class`. Passing
`class="rush-load"` replaces that default. The two names are not
concatenated. Writing `class="scale-slip"` on the same tag as `{@rest}`
emits a second class attribute; the HTML parser keeps the first, so the
empennage ticket shows `scale-slip` and never `join-ticket`.

**Why it matters.** The docs say the default map is "merged". Map merge
replaces the `class` key. A static class on the same tag hides the rest
class entirely.

**What to do.** Put the class on rest, not also on the tag. Concatenate
caller and default classes yourself if you need both names.

**Seen in:** [Tianjin assembly tickets](features/04-function-components-and-heex/05-tianjin-assembly-tickets/).

### Map.put on component assigns freezes that key after the first render

**What happens.** Inside a function component, `Map.put(assigns, :fired_pass, ...)`
updates the Elixir map but does not mark `__changed__`. `{@fired_pass}`
keeps the first pass even while `{@loft_temp}` updates.
`Phoenix.Component.assign/3` marks the key, so the assign chip's pass
moves. A quiet chip that was never passed `loft_temp` does not recompute
its pass when only the loft changes.

**Why it matters.** A firing pass, timestamp, or generated id written with
`Map.put/3` looks live in the first paint and then never moves.

**What to do.** Use `assign/3`, `assign_new/3`, or `update/3` inside
function components, never `Map.put/3`, if the template should see later
values.

**Seen in:** [Friedrichshafen dope board](features/04-function-components-and-heex/09-friedrichshafen-dope-board/).

### values: does not reject a dynamic assign at runtime

**What happens.** `attr :mark, :atom, values: [:c, :d, :e]`
warns at compile time for a literal outside the list. `mark={@mark}`
with `@mark == :naval` still renders. A direct `gripen_tray/1` call
missing `:mark` raises `KeyError` from `@mark`, not an
`ArgumentError` from `attr/3`. Defaults still apply on that direct call.

**Why it matters.** `values:` looks like a guard. A tray load from a
form or assign will print an unlisted mark without a warning.

**What to do.** Do not treat `values:` as a runtime guard. Check the assign
in Elixir if the tray must refuse an unlisted mark.

**Seen in:** [Linköping Gripen trays](features/04-function-components-and-heex/11-linkoping-gripen-trays/).

### Seeding to_form/2 with the field value makes used_input?/1 true

**What happens.** `used_input?/1` is true when the field is present in form
params without an `_unused_` sibling. `to_form(%{"dispatcher" => "Ngaio"}, as: :permit)`
therefore reports the dispatcher field as used on first paint, before anyone
typed. Starting from `to_form(%{}, as: :permit)` keeps it untouched until
`phx-change` sends the field.

**Why it matters.** Prefilling the dispatcher name to show a default also
unlocks "used" errors and copy on first paint.

**What to do.** Seed `to_form/2` with an empty params map if you need the
untouched state. Put the displayed name in a separate assign.

**Seen in:** [Milford Sound permits](features/04-function-components-and-heex/10-milford-sound-permits/).

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
clocks, subscribe, and trap exits only when `connected?(socket)` is true. Put
leave-side effects in `terminate/2` of the connected process.

**Seen in:** [Nuuk night board](features/06-liveview-lifecycle-and-events/13-nuuk-night-board/).

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

**Seen in:** [Rarotonga ATIS watch](features/06-liveview-lifecycle-and-events/12-rarotonga-atis-watch/).

### `send(self())` from `handle_event/3` is applied after that event's render

**What happens.** `send(self(), :strike_sock)` inside `handle_event/3`
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

**Seen in:** [Juist windsock book](features/06-liveview-lifecycle-and-events/09-juist-windsock-book/).

### `temporary_assigns` reset the socket, not the last DOM node

**What happens.** A `last_sighting` listed in `temporary_assigns` appears
in the HTML returned by `render_click/1`. After that render, the assign is
reset to the mount value (`nil`) and is not marked changed, so LiveView
does not patch `#last-sighting`. A later event that reads the assign sees
`nil` ("cleared") while the old sighting stays on the page. A go-around
that never touches `last_sighting` leaves that node in place. A regular
assign (`posted_bearings`) keeps every line and does patch.

**Why it matters.** The page still shows a sighting the socket has already
forgotten. Accumulating into a temporary assign loses the prefix. Clearing
the node requires assigning that key again.

**What to do.** Put values you must keep in a regular assign. Use
`temporary_assigns` only for payloads that are safe to forget after the
diff goes out, and re-assign the key when the DOM must change.

**Seen in:** [Ämari range log](features/06-liveview-lifecycle-and-events/10-amari-range-log/).

### `push_event/3` from the disconnected render is discarded

**What happens.** `mount/3` calls `push_event(socket, "arm_stack", %{connected: connected?(socket), ...})` on both renders. After `live/2`,
`assert_push_event` receives one payload, with `connected: true`. The
static payload with `connected: false` never arrives. There is no channel
during `Phoenix.LiveView.Static.render/3`, and the connected mount is a
new socket.

**Why it matters.** A chart, canvas, or stack console that arms itself from
a mount-time push must push again on the connected mount, or the client
hook never sees it.

**What to do.** Push from the connected mount (`if connected?(socket) do`),
or push again from an event the hook sends after `mounted()`.

**Seen in:** [Andøya rocket events](features/06-liveview-lifecycle-and-events/11-andoya-rocket-events/).

### `phx-value-*` payloads are always strings

**What happens.** `phx-value-period="15"` and `phx-value-cells="2"` arrive
in `handle_event/3` as `"15"` and `"2"`. `is_binary(period)` is true. A
click with no `phx-value-*` still fires, with an empty map.

**Why it matters.** `period + 1` and `period == 15` both fail. The card
has to parse, and it has to accept `nil` when the clear button sends
nothing.

**What to do.** Parse in `handle_event/3`. Do not pattern-match integers
out of `phx-value-*`.

**Seen in:** [Kota Kinabalu monsoon card](features/06-liveview-lifecycle-and-events/02-kota-kinabalu-monsoon-card/).

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

**Seen in:** [Vágar weather round](features/06-liveview-lifecycle-and-events/06-vagar-weather-round/).

### `phx-debounce` and `phx-throttle` are client-side; LiveViewTest does not wait

**What happens.** `phx-debounce="500"`, `phx-debounce="blur"`, and
`phx-throttle="2000"` stay in the markup. `render_change/2` posts radio
copy immediately. Two `render_click/1` calls a millisecond apart both
increment the jet-stream table.

**Why it matters.** A test cannot prove the delay. It can prove the
attribute is present and that the server handles the event when it
arrives. A test that expected "only one click per two seconds" will fail
under LiveViewTest even when the browser throttles.

**What to do.** Assert the attribute and the server-side result. Do not
assert timing in `Phoenix.LiveViewTest`. Time the browser if the delay is
the behavior that matters.

**Seen in:** [St Helena relief board](features/06-liveview-lifecycle-and-events/07-st-helena-relief-board/),
[Keflavik jet-stream table](features/06-liveview-lifecycle-and-events/08-keflavik-jetstream-table/).

### `phx-submit` does not send `_target`

**What happens.** `phx-change` params include `"_target"` naming the field
that moved. `phx-submit` params on the same form do not. A stand clerk
slate that records `had_target?` from `Map.has_key?(params, "_target")`
reads yes on change and no on submit.

**Why it matters.** Code that always pattern-matches `"_target"` will fail
to compile a match on submit, or will skip the assign-stand clause.

**What to do.** Use different event names for change and submit. Read
`_target` only in the change callback.

**Seen in:** [Tivat stand slate](features/06-liveview-lifecycle-and-events/04-tivat-stand-slate/),
[Overberg lamp round](features/06-liveview-lifecycle-and-events/03-overberg-lamp-round/).

## Controllers and JSON

### `json/2` keeps the status `put_status/2` already set

**What happens.** `put_status(:created)` then `json/2` is 201. `put_status(:accepted)`
then `render/3` is 202 with an HTML body. `json/2` alone is 200.

**Why it matters.** `json/2` looks like it might reset the status to OK.
It does not. The body and the status are independent.

**What to do.** Set the status first when 201 or 202 is the point. Do not
expect `json/2` to imply Created.

**Seen in:** [Cusco load sheet](features/03-controllers-and-json/02-cusco-load-sheet/),
[Bariloche Chinook brief](features/03-controllers-and-json/05-bariloche-chinook-brief/).

### `action_fallback` sees tagged tuples; `rescue` sees exceptions

**What happens.** `{:error, :not_found}` from `show/2` hits the fallback
(`via: "fallback"`). `String.to_integer("runway-Q")` raises `ArgumentError`.
The rescued clause answers 422 (`via: "rescue"`). The fallback never runs.

**Why it matters.** A fallback looks like a catch-all error door. It only
runs when the action returns an error tuple, not when Elixir raises.

**What to do.** Return `{:error, reason}` for expected misses. Rescue only
for exceptions you intend to translate.

**Seen in:** [Ulaanbaatar winter NOTAM](features/03-controllers-and-json/04-ulaanbaatar-winter-notam/).

### A JSON 404 is not ErrorHTML's `"Not Found"` page

**What happens.** `put_status(:not_found)` then `json/2` returns
`{"error":"slot_missing",...}`. The resp body is not `"Not Found"` and
not an HTML document.

**Why it matters.** A client that expected the default error page, or a
test that asserted `"Not Found"`, misses the map the action actually sent.

**What to do.** Decide per action whether a miss is ErrorHTML/ErrorJSON or
your own JSON map. `json_response(conn, 404)` reads the map.

**Seen in:** [Malé atoll slot list](features/03-controllers-and-json/09-male-atoll-slot-list/).

### Nested params do not match a flat clause

**What happens.** `create(conn, %{"card" => %{"oat_c" => oat, ...}})`
matches a nested post. The same keys at the top level (`%{"oat_c" => ...}`)
miss that clause and hit the fallback 422 (`nested: false`).

**Why it matters.** A JSON client that posts a flat map looks "almost
right" and never enters the domain clause.

**What to do.** Nest under the domain key the action pattern-matches, or
add a clause that accepts the flat shape.

**Seen in:** [Leh density-altitude card](features/03-controllers-and-json/10-leh-density-altitude-card/).

### `send_resp/3` skips the view and the layout

**What happens.** `put_resp_content_type("text/plain")` then `send_resp/3`
writes the oxygen ticket. The body has no `<html>` and no `catalog-shell`.

**Why it matters.** A later `render/3` in the same action would be
`AlreadySentError`. Tests that look for the catalog chrome will fail even
when the ticket is correct.

**What to do.** Use `send_resp/3` when the body is the ticket. Do not also
render.

**Seen in:** [Lhasa oxygen plan](features/03-controllers-and-json/11-lhasa-oxygen-plan/).

## Core components and layouts

### Overriding a core input class drops the defaults

**What happens.** `<.input class="...border-amber-600...">` emits that
class list. The default `w-full input` string is gone. The field still
posts QNH.

**Why it matters.** A class override looks like "add these utilities".
None of the default input classes are inherited.

**What to do.** When you pass `class`, fully style the input. Keep the
default class if you still want the daisy input look.

**Seen in:** [Eilat desert banner](features/05-core-components-and-layouts/04-eilat-desert-banner/).

### `live_title` suffix belongs to the root layout

**What happens.** The LiveView assigns `page_title` `"Prestwick Atlantic title"`.
The static HTML title is `Prestwick Atlantic title · Phoenix`. The suffix
is in `root.html.heex`, not in the LiveView.

**Why it matters.** A test or a tab title that expected only the assign
misses the suffix. Retitling the assign does not move ` · Phoenix`.

**What to do.** Treat `page_title` as the prefix. Assert the suffix if the
document title is the behavior.

**Seen in:** [Prestwick Atlantic title](features/05-core-components-and-layouts/06-prestwick-atlantic-title/).

## LiveView navigation

### The first `handle_params/3` after `live/2` is still the mount run

**What happens.** `live/2` connects the socket and runs `handle_params/3`.
A counter that starts at 0 still records that run as `:mount`, not
`:patch`. The sahel button is the first `:patch`.

**Why it matters.** A test that treats "already connected" as "already
patched" will expect the wrong via on the first paint.

**What to do.** Count params runs. The first is mount. Only a later
`push_patch` is a patch.

**Seen in:** [Timbuktu dust params](features/07-liveview-navigation/06-timbuktu-dust-params/).

### A query key survives a patch only if the new `~p` still lists it

**What happens.** QNH 1021 is in the URL. Patching the watch with
`~p"...?#{[qnh: socket.assigns.qnh, watch: "evening"]}"` keeps 1021.
Leaving `qnh` out of the keyword list would drop it.

**Why it matters.** "The rest of the query string stays" looks true. It
is only true when the patch builds the query again.

**What to do.** Pass every key you still want. Do not expect the old
query to merge.

**Seen in:** [Gelephu QNH query](features/07-liveview-navigation/09-gelephu-qnh-query/).

## Async assigns

### `assign_async/3` does not start on the disconnected mount

**What happens.** A `get` of the Puerto Natales desk shows the loading
copy and no `32022G34KT`. `live/2` plus `render_async/2` then fills the
wind.

**Why it matters.** The dead HTML looks like "the fetch already ran and
is waiting." The task has not started. There is no result to cache.

**What to do.** Treat the static paint as loading. Assert the value
only after `render_async/2`.

**Seen in:** [Puerto Natales wind fetch](features/08-async-assigns/01-puerto-natales-wind-fetch/).

### `{:error, reason}` lands in `.failed` as `{:error, reason}`

**What happens.** The function returns `{:error, :sounding_timeout}`.
`@sounding.failed` is `{:error, :sounding_timeout}`, not the bare atom.
An exiting task is `{:exit, :hoist_cable_snap}`.

**Why it matters.** A template or test that matches only
`:sounding_timeout` misses the tagged tuple LiveView actually stored.

**What to do.** Inspect or pattern-match the tagged tuple. Retry by
starting `assign_async` again.

**Seen in:** [Walvis Bay timeout](features/08-async-assigns/12-walvis-bay-timeout/),
[Norilsk hoist exit](features/08-async-assigns/11-norilsk-hoist-exit/),
[Van icing retry](features/08-async-assigns/04-van-icing-retry/).
