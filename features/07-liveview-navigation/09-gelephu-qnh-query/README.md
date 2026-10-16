# LiveView navigation · 09 · Gelephu QNH query

Clerk Pema keeps QNH 1021 on a Dornier 228 at Gelephu while patching from morning to evening. The query string still carries the pressure.

**What it teaches**

- Query params survive a patch that only changes another key.
- `handle_params/3` still sees the kept QNH.

**Files**

| File | Role |
| --- | --- |
| [`qnh_query_live.ex`](qnh_query_live.ex) | Patch that keeps qnh |
| [`qnh_query_live_test.exs`](qnh_query_live_test.exs) | 1021 survives the evening patch |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/07-liveview-navigation/09-gelephu-qnh-query](http://localhost:4000/features/07-liveview-navigation/09-gelephu-qnh-query).

```sh
mix test features/07-liveview-navigation/09-gelephu-qnh-query/qnh_query_live_test.exs
```
