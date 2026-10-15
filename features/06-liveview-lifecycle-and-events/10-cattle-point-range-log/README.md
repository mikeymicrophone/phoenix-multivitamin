# LiveView lifecycle and events · 10 · Cattle Point range log

Keeper Briony logs the range lights at Cattle Point Light, looking down
Cattle Pass. Posted bearings are a regular assign that accumulate. The last
sighting is a `temporary_assigns` key: it renders once, then resets.

**What it teaches**

- A regular assign (`posted_bearings`) keeps its value across renders.
- `temporary_assigns: [last_sighting: nil]` resets that key to `nil` after
  every render. The click's HTML includes the sighting.
- The reset does not patch the DOM until `last_sighting` is assigned
  again. Confirming the sighting reads `"cleared"` from the socket while
  `#last-sighting` still shows the front range. A ferry wake leaves that
  old node in place too.

**Files**

| File | Role |
| --- | --- |
| [`range_log_live.ex`](range_log_live.ex) | The LiveView: accumulated bearings vs a temporary sighting |
| [`range_log_live_test.exs`](range_log_live_test.exs) | LiveViewTest for the reset-after-render behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/10-cattle-point-range-log](http://localhost:4000/features/06-liveview-lifecycle-and-events/10-cattle-point-range-log).
Log the front range, then the ferry wake. The last sighting clears.

```sh
mix test features/06-liveview-lifecycle-and-events/10-cattle-point-range-log/range_log_live_test.exs
```
