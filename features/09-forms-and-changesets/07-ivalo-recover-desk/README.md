# Forms and changesets · 07 · Ivalo recover desk

Clerk Sisko keeps a Fokker 50 deice card at Ivalo. A dropped socket recovers the fluid through phx-auto-recover.

**What it teaches**

- `phx-auto-recover` fires a named event with the form values after a dropped socket.

**Files**

| File | Role |
| --- | --- |
| [`deice_card.ex`](deice_card.ex) | Fluid and tank changeset |
| [`recover_desk_live.ex`](recover_desk_live.ex) | recover_deice event |
| [`recover_desk_live_test.exs`](recover_desk_live_test.exs) | Recovered fluid is Type IV |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/07-ivalo-recover-desk](http://localhost:4000/features/09-forms-and-changesets/07-ivalo-recover-desk).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/07-ivalo-recover-desk/recover_desk_live_test.exs
```
