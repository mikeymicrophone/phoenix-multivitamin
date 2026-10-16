# Async assigns · 04 · Van icing retry

Clerk Berfin reads icing on an Antonov An-74 at Van. The first probe is `{:error, :icing_probe_dark}`. Retry lights it.

**What it teaches**

- The failed tuple paints the reason.
- A retry event starts `assign_async` again.

**Files**

| File | Role |
| --- | --- |
| [`icing_retry_live.ex`](icing_retry_live.ex) | Failed then retry |
| [`icing_retry_live_test.exs`](icing_retry_live_test.exs) | icing_probe_dark then trace ice |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/04-van-icing-retry](http://localhost:4000/features/08-async-assigns/04-van-icing-retry).

```sh
mix test features/08-async-assigns/04-van-icing-retry/icing_retry_live_test.exs
```
