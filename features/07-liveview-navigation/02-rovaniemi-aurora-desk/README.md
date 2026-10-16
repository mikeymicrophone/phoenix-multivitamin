# LiveView navigation · 02 · Rovaniemi aurora desk

Clerk Aino keeps an ATR 72 aurora desk at Rovaniemi. Opening the cabin `navigate/2`s to a different LiveView. Desk clicks stay on the desk process.

**What it teaches**

- `navigate/2` mounts a different LiveView.
- Assigns on the desk do not survive the cabin.

**Files**

| File | Role |
| --- | --- |
| [`aurora_desk_live.ex`](aurora_desk_live.ex) | Desk LiveView and navigate |
| [`aurora_cabin_live.ex`](aurora_cabin_live.ex) | Cabin LiveView |
| [`aurora_desk_live_test.exs`](aurora_desk_live_test.exs) | follow_redirect onto the cabin |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/02-rovaniemi-aurora-desk](http://localhost:4000/features/07-liveview-navigation/02-rovaniemi-aurora-desk).

```sh
mix test features/07-liveview-navigation/02-rovaniemi-aurora-desk/aurora_desk_live_test.exs
```
