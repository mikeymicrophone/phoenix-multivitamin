# Async assigns · 01 · Puerto Natales wind fetch

Clerk Esperanza fetches wind for a Pilatus PC-6 at Puerto Natales. `assign_async/3` starts from mount and only runs once the socket connects.

**What it teaches**

- `assign_async/3` started from mount.
- The task starts only when the socket is connected.

**Files**

| File | Role |
| --- | --- |
| [`wind_fetch_live.ex`](wind_fetch_live.ex) | assign_async from mount |
| [`wind_fetch_live_test.exs`](wind_fetch_live_test.exs) | Dead loading then render_async |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/01-puerto-natales-wind-fetch](http://localhost:4000/features/08-async-assigns/01-puerto-natales-wind-fetch).

```sh
mix test features/08-async-assigns/01-puerto-natales-wind-fetch/wind_fetch_live_test.exs
```
