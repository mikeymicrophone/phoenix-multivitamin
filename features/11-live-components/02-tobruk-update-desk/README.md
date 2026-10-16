# LiveComponents · 02 · Tobruk update desk

Clerk Iman swings an Antonov An-8 stand. The cell sees the new stand through update/2.

**What it teaches**

- `update/2` runs again when the parent changes an assign.

**Files**

| File | Role |
| --- | --- |
| [`update_cell.ex`](update_cell.ex) | Counts each update |
| [`update_desk_live.ex`](update_desk_live.ex) | Parent swings the stand |
| [`update_desk_live_test.exs`](update_desk_live_test.exs) | West is the second update |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/02-tobruk-update-desk](http://localhost:4000/features/11-live-components/02-tobruk-update-desk).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/02-tobruk-update-desk/update_desk_live_test.exs
```
