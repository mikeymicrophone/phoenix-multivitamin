# LiveView navigation · 05 · Phu Quoc stand replace

Clerk Linh slides an ATR 42 onto stand B7 at Phu Quoc with `push_patch(..., replace: true)` so the watch does not stack history.

**What it teaches**

- `replace: true` still runs `handle_params/3`.
- The stand swaps without stacking a second history entry.

**Files**

| File | Role |
| --- | --- |
| [`stand_replace_live.ex`](stand_replace_live.ex) | replace: true patch |
| [`stand_replace_live_test.exs`](stand_replace_live_test.exs) | Stand B7 after replace |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/05-phu-quoc-stand-replace](http://localhost:4000/features/07-liveview-navigation/05-phu-quoc-stand-replace).

```sh
mix test features/07-liveview-navigation/05-phu-quoc-stand-replace/stand_replace_live_test.exs
```
