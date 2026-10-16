# LiveComponents · 12 · Bodø survive cell

Clerk Sigrid ticks a Lockheed P-3 Orion parent. The cell keeps the same id and does not remount.

**What it teaches**

- The same `id` keeps `mount/1` from running again on a parent re-render.

**Files**

| File | Role |
| --- | --- |
| [`survive_cell.ex`](survive_cell.ex) | mounts stays 1 |
| [`survive_cell_live.ex`](survive_cell_live.ex) | Parent ticks |
| [`survive_cell_live_test.exs`](survive_cell_live_test.exs) | Ticks rise; mounts stay 1 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/12-bodo-survive-cell](http://localhost:4000/features/11-live-components/12-bodo-survive-cell).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/12-bodo-survive-cell/survive_cell_live_test.exs
```
