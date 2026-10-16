# Async assigns · 10 · Tamanrasset density reset

Clerk Yasmina recomputes density altitude for a CASA C-295 at Tamanrasset. `reset: true` clears the last card while the next one loads.

**What it teaches**

- `reset: true` clears the previous result while loading.
- A later `assign_async` fills a new card.

**Files**

| File | Role |
| --- | --- |
| [`density_reset_live.ex`](density_reset_live.ex) | reset: true on recompute |
| [`density_reset_live_test.exs`](density_reset_live_test.exs) | 4440 clears, then 4510 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/10-tamanrasset-density-reset](http://localhost:4000/features/08-async-assigns/10-tamanrasset-density-reset).

```sh
mix test features/08-async-assigns/10-tamanrasset-density-reset/density_reset_live_test.exs
```
