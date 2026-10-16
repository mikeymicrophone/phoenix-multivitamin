# LiveComponents · 01 · Qaanaaq frost cell

Clerk Niviaq keeps frost taps for a DHC-3 Otter in a cell with its own id.

**What it teaches**

- A stateful LiveComponent keeps taps under its own `id`.

**Files**

| File | Role |
| --- | --- |
| [`frost_cell.ex`](frost_cell.ex) | Taps live in the cell |
| [`frost_cell_live.ex`](frost_cell_live.ex) | Parent mounts the cell |
| [`frost_cell_live_test.exs`](frost_cell_live_test.exs) | A tap increments inside the cell |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/01-qaanaaq-frost-cell](http://localhost:4000/features/11-live-components/01-qaanaaq-frost-cell).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/01-qaanaaq-frost-cell/frost_cell_live_test.exs
```
