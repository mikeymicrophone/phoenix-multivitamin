# LiveView lifecycle and events · 03 · Overberg lamp round

Lampie Piet walks the lamp round at the Overberg Test Range, before the
Atlas Cheetah rolls. The runway PAPI, threshold bar, and tower beacon
each post on `phx-change`. The event map includes `_target`, so the
sheet knows which lamp moved.

**What it teaches**

- `phx-change` on a form sends every field plus `"_target"` for the input
  that changed. A select named `round[runway_papi]` arrives as
  `"_target" => ["round", "runway_papi"]`.
- `handle_event/3` can switch on that target and leave the other lamps
  alone.
- No submit is required. Each change is its own round-sheet line.

**Files**

| File | Role |
| --- | --- |
| [`lamp_round_live.ex`](lamp_round_live.ex) | The LiveView: the round sheet and `_target` handling |
| [`lamp_round_live_test.exs`](lamp_round_live_test.exs) | ConnTest for the empty sheet, LiveViewTest for change events |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/03-overberg-lamp-round](http://localhost:4000/features/06-liveview-lifecycle-and-events/03-overberg-lamp-round).
Set the PAPI to trimmed, then bank the threshold bar.

```sh
mix test features/06-liveview-lifecycle-and-events/03-overberg-lamp-round/lamp_round_live_test.exs
```
