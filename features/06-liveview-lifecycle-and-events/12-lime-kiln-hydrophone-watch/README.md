# LiveView lifecycle and events · 12 · Lime Kiln hydrophone watch

Listener Asta sits the hydrophone booth at Lime Kiln State Park, on the
west side of San Juan Island. `on_mount` dons the headset before `mount/3`
and attaches a `handle_event` hook. Orca marks continue into the LiveView.
Calibration halts in the hook.

**What it teaches**

- `on_mount/1` runs before `mount/3`, on the disconnected HTTP render and
  again on the connected mount. Those are different processes, so a booth
  counter sees two dons from `live/2` and one from `get/2`.
- Assigns set in `on_mount` are visible in `mount/3`. This view uses that
  to prove the hook ran first (`hook_then_mount`).
- `attach_hook/4` from `on_mount` intercepts `handle_event/3`.
  `{:cont, socket}` lets the LiveView callback run. `{:halt, socket}` skips
  it, which is how calibration never reaches `handle_event("calibrate_array", ...)`.

**Files**

| File | Role |
| --- | --- |
| [`hydrophone_watch_live.ex`](hydrophone_watch_live.ex) | The LiveView: on_mount, the hook, and the detection log |
| [`hydrophone_booth.ex`](hydrophone_booth.ex) | An Agent the tests use to count dons across processes |
| [`hydrophone_watch_live_test.exs`](hydrophone_watch_live_test.exs) | ConnTest and LiveViewTest for double on_mount and halt |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/12-lime-kiln-hydrophone-watch](http://localhost:4000/features/06-liveview-lifecycle-and-events/12-lime-kiln-hydrophone-watch).
Mark J pod, then calibrate the array.

```sh
mix test features/06-liveview-lifecycle-and-events/12-lime-kiln-hydrophone-watch/hydrophone_watch_live_test.exs
```
