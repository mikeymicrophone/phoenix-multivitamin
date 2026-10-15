# LiveView lifecycle and events · 02 · Point Wilson fog signal card

Keeper Evander posts the fog signal at Point Wilson Light, on the spit north
of Port Townsend. Each button sends the characteristic on `phx-value-*`
attributes: two blasts every 15 seconds, one blast every 10, or silence.

**What it teaches**

- `phx-click` with `phx-value-*` puts those attributes into the
  `handle_event/3` payload. `phx-value-characteristic="two-blasts"` arrives
  as `%{"characteristic" => "two-blasts"}`.
- Every `phx-value-*` is a string. `"15"` is not `15`. Hyphenated names such
  as `phx-value-characteristic` keep the hyphen out of the key because the
  suffix after `phx-value-` is the key; `characteristic` is the key here.
- A click with no `phx-value-*` still fires the event, with an empty map.
  Silence is the fallback.

**Files**

| File | Role |
| --- | --- |
| [`fog_signal_card_live.ex`](fog_signal_card_live.ex) | The LiveView: fog signal buttons and the posted card |
| [`fog_signal_card_live_test.exs`](fog_signal_card_live_test.exs) | LiveViewTest for string payloads and the empty map |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/02-point-wilson-fog-signal-card](http://localhost:4000/features/06-liveview-lifecycle-and-events/02-point-wilson-fog-signal-card).
Post two blasts, then silence the signal.

```sh
mix test features/06-liveview-lifecycle-and-events/02-point-wilson-fog-signal-card/fog_signal_card_live_test.exs
```
