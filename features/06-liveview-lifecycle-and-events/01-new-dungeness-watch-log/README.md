# LiveView lifecycle and events · 01 · New Dungeness watch log

Keeper Maren posts the evening watch at New Dungeness Light Station. The
disconnected mount is a paper log. The connected mount arms a station clock
with `Process.send_after/3`. Buttons append fog, the cannery tender Retort,
a trimmed wick, and a watch bell. Patching to midwatch hands the board to
Alden.

**What it teaches**

- `mount/3` runs twice: once for the static HTML, again when the socket
  connects. `connected?/1` is false, then true.
- The watch clock is armed with `Process.send_after/3` only on the connected
  mount. A 60 second tick will not fire during `mix test`.
- `handle_params/3` reads `watch` from the URL. Evening is Maren at 20:00.
  Midwatch is Alden at 00:00.
- `handle_event/3` appends a domain line for each button. The empty state
  leaves once the first line is posted.
- `handle_info/2` receives `:station_tick` and advances the clock without a
  client round-trip.

**Files**

| File | Role |
| --- | --- |
| [`watch_log_live.ex`](watch_log_live.ex) | The LiveView: mount, params, events, and the clock |
| [`watch_log_live_test.exs`](watch_log_live_test.exs) | ConnTest for the static mount, LiveViewTest for events and the patch |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/01-new-dungeness-watch-log](http://localhost:4000/features/06-liveview-lifecycle-and-events/01-new-dungeness-watch-log).
Log a fog bank. Patch to midwatch. The clock is armed; it ticks once a
minute.

Run the test with the rest of the bottle:

```sh
mix test features/06-liveview-lifecycle-and-events/01-new-dungeness-watch-log/watch_log_live_test.exs
```
