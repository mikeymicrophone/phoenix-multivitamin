# Async assigns · 02 · Mawlamyine monsoon loading

Clerk Su waits on a monsoon sounding for a Fokker 70 at Mawlamyine. The `<.async_result>` loading slot paints until the task returns.

**What it teaches**

- The loading slot of `<.async_result>`.
- The sounding stays out until `render_async/2`.

**Files**

| File | Role |
| --- | --- |
| [`monsoon_loading_live.ex`](monsoon_loading_live.ex) | async_result loading slot |
| [`monsoon_loading_live_test.exs`](monsoon_loading_live_test.exs) | Loading then ok |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/02-mawlamyine-monsoon-loading](http://localhost:4000/features/08-async-assigns/02-mawlamyine-monsoon-loading).

```sh
mix test features/08-async-assigns/02-mawlamyine-monsoon-loading/monsoon_loading_live_test.exs
```
