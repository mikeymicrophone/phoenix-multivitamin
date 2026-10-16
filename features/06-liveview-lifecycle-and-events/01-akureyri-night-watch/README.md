# LiveView lifecycle and events · 01 · Akureyri night watch

Controller Sólrún posts the evening watch at Akureyri Airport. The
disconnected mount is a paper log. The connected mount arms a station clock
with `Process.send_after/3`. Buttons append ice pellets, the inbound
Fokker 50, a trimmed ice light, and an ATIS bell. Patching to midwatch
hands the board to Egill.

**What it teaches**

- `mount/3` runs twice: once for the static HTML, again when the socket
  connects. `connected?/1` is false, then true.
- The watch clock is armed with `Process.send_after/3` only on the connected
  mount. A 60 second tick will not fire during `mix test`.
- `handle_params/3` reads `watch` from the URL. Evening is Sólrún at 20:00.
  Midwatch is Egill at 00:00.
- `handle_event/3` appends a domain line for each button. The empty state
  leaves once the first line is posted.
- `handle_info/2` receives `:station_tick` and advances the clock without a
  client round-trip.

**Files**

| File | Role |
| --- | --- |
| [`night_watch_live.ex`](night_watch_live.ex) | The LiveView: mount, params, events, and the clock |
| [`night_watch_live_test.exs`](night_watch_live_test.exs) | ConnTest for the static mount, LiveViewTest for events and the patch |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/01-akureyri-night-watch](http://localhost:4000/features/06-liveview-lifecycle-and-events/01-akureyri-night-watch).
Log ice pellets. Patch to midwatch. The clock is armed; it ticks once a
minute.

Run the test with the rest of the bottle:

```sh
mix test features/06-liveview-lifecycle-and-events/01-akureyri-night-watch/night_watch_live_test.exs
```
