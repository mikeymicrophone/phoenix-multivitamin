# LiveComponents · 05 · Coyhaique brief cell

Clerk Ximena fetches an Andes brief for a Cessna 337 Skymaster. The parent sends itself a message, then update/2 fills the cell.

**What it teaches**

- `send(self(), msg)` on the parent, then `update/2` on the cell.

**Files**

| File | Role |
| --- | --- |
| [`brief_cell.ex`](brief_cell.ex) | update/2 takes the brief |
| [`brief_cell_live.ex`](brief_cell_live.ex) | Parent handle_info assigns the brief |
| [`brief_cell_live_test.exs`](brief_cell_live_test.exs) | The cell shows the Andes wave |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/05-coyhaique-brief-cell](http://localhost:4000/features/11-live-components/05-coyhaique-brief-cell).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/05-coyhaique-brief-cell/brief_cell_live_test.exs
```
