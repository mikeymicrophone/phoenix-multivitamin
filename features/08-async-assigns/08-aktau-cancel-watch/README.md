# Async assigns · 08 · Aktau cancel watch

Clerk Aigerim cancels the evening METAR on an Antonov An-24 at Aktau when the watch patches. Midwatch starts a new fetch.

**What it teaches**

- `cancel_async/3` kills the in-flight METAR when the watch changes.
- The cancelled result is `{:exit, {:shutdown, :cancel}}`.

**Files**

| File | Role |
| --- | --- |
| [`cancel_watch_live.ex`](cancel_watch_live.ex) | Cancel then fetch the new watch |
| [`cancel_watch_live_test.exs`](cancel_watch_live_test.exs) | Midwatch METAR, not evening late |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/08-aktau-cancel-watch](http://localhost:4000/features/08-async-assigns/08-aktau-cancel-watch).

```sh
mix test features/08-async-assigns/08-aktau-cancel-watch/cancel_watch_live_test.exs
```
