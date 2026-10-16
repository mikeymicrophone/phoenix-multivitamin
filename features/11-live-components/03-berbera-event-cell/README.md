# LiveComponents · 03 · Berbera event cell

Clerk Hodan parks a Shorts 330 inside the cell. The parent never hears the click.

**What it teaches**

- `handle_event/3` with `phx-target={@myself}` stays in the component.

**Files**

| File | Role |
| --- | --- |
| [`event_cell.ex`](event_cell.ex) | Park south in the cell |
| [`event_cell_live.ex`](event_cell_live.ex) | Parent stand stays quiet |
| [`event_cell_live_test.exs`](event_cell_live_test.exs) | South is in the cell only |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/03-berbera-event-cell](http://localhost:4000/features/11-live-components/03-berbera-event-cell).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/03-berbera-event-cell/event_cell_live_test.exs
```
