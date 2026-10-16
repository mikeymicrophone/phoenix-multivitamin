# Async assigns · 12 · Walvis Bay timeout

Clerk Ndapewa waits twenty milliseconds for a CRJ700 sounding at Walvis Bay. The function returns `{:error, :sounding_timeout}`. That is the failed reason.

**What it teaches**

- A receive-after timeout returns `{:error, :sounding_timeout}`.
- The failed reason you actually get is `{:error, :sounding_timeout}`.

**Files**

| File | Role |
| --- | --- |
| [`timeout_live.ex`](timeout_live.ex) | receive after 20 |
| [`timeout_live_test.exs`](timeout_live_test.exs) | Failed reason shape |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/12-walvis-bay-timeout](http://localhost:4000/features/08-async-assigns/12-walvis-bay-timeout).

```sh
mix test features/08-async-assigns/12-walvis-bay-timeout/timeout_live_test.exs
```
