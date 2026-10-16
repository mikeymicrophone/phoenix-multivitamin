# Streams · 11 · Calama insert after

Clerk Rocío slides a mid sector for the Boeing 787-8 after Chuquicamata north.

**What it teaches**

- `stream_insert/4` with `at: 1` inserts after a given row.

**Files**

| File | Role |
| --- | --- |
| [`insert_after_live.ex`](insert_after_live.ex) | Insert at 1 |
| [`insert_after_live_test.exs`](insert_after_live_test.exs) | Mid sits between north and south |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/11-calama-insert-after](http://localhost:4000/features/10-streams/11-calama-insert-after).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/11-calama-insert-after/insert_after_live_test.exs
```
