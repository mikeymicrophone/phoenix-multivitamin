# LiveView lifecycle and events · 12 · Rarotonga ATIS watch

Booth tech Manu sits the ATIS booth at Rarotonga, before the Airbus
A350-900 arrives. `on_mount` dons the headset before `mount/3` and
attaches a `handle_event` hook. Arrival marks continue into the LiveView.
Calibration halts in the hook.

**What it teaches**

- `on_mount/1` runs before `mount/3`, on the disconnected HTTP render and
  again on the connected mount. Those are different processes, so a booth
  counter sees two dons from `live/2` and one from `get/2`.
- Assigns set in `on_mount` are visible in `mount/3`. This view uses that
  to prove the hook ran first (`hook_then_mount`).
- `attach_hook/4` from `on_mount` intercepts `handle_event/3`.
  `{:cont, socket}` lets the LiveView callback run. `{:halt, socket}` skips
  it, which is how calibration never reaches `handle_event("calibrate_atis", ...)`.

**Files**

| File | Role |
| --- | --- |
| [`atis_watch_live.ex`](atis_watch_live.ex) | The LiveView: on_mount, the hook, and the ATIS log |
| [`atis_booth.ex`](atis_booth.ex) | An Agent the tests use to count dons across processes |
| [`atis_watch_live_test.exs`](atis_watch_live_test.exs) | ConnTest and LiveViewTest for double on_mount and halt |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/12-rarotonga-atis-watch](http://localhost:4000/features/06-liveview-lifecycle-and-events/12-rarotonga-atis-watch).
Mark ANZ84, then calibrate the ATIS.

```sh
mix test features/06-liveview-lifecycle-and-events/12-rarotonga-atis-watch/atis_watch_live_test.exs
```
