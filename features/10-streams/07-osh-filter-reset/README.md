# Streams · 07 · Osh filter reset

Clerk Aigul filters Antonov An-28 legs at Osh and resets the stream.

**What it teaches**

- `stream/4` with `reset: true` replaces the board after a filter.
- Guarded helper clauses accept all, east, or west; a filtered `for` selects the requested legs.
- `with` leaves the current stream intact when the direction is unsupported.

**Files**

| File | Role |
| --- | --- |
| [`filter_reset_live.ex`](filter_reset_live.ex) | East filter resets the stream |
| [`filter_reset_live_test.exs`](filter_reset_live_test.exs) | Khujand leaves |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/07-osh-filter-reset](http://localhost:4000/features/10-streams/07-osh-filter-reset).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/07-osh-filter-reset/filter_reset_live_test.exs
```
