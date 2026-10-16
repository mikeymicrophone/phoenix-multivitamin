# Async assigns · 07 · Upernavik triple fetch

Clerk Ivalu pulls wind, temperature, and QNH for a Dash 8-200 at Upernavik in one `assign_async/3` function.

**What it teaches**

- Several async assigns in flight together.
- One function returns every key.

**Files**

| File | Role |
| --- | --- |
| [`triple_fetch_live.ex`](triple_fetch_live.ex) | Three keys from one function |
| [`triple_fetch_live_test.exs`](triple_fetch_live_test.exs) | Wind, temp, and QNH together |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/07-upernavik-triple-fetch](http://localhost:4000/features/08-async-assigns/07-upernavik-triple-fetch).

```sh
mix test features/08-async-assigns/07-upernavik-triple-fetch/triple_fetch_live_test.exs
```
