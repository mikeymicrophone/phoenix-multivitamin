# Streams · 08 · Mohe limit tape

Clerk Bai keeps three Comac ARJ21 tape lines at Mohe. A new aurora line pushes QNH off the end.

**What it teaches**

- `limit: 3` keeps three rows.
- `stream_insert/4` must pass `limit` again or the cap is not enforced.
- A zipped `for` comprehension pairs the tape IDs and bodies.
- Appending with `at: -1, limit: -3` keeps the last three lines instead of the first three.

**Files**

| File | Role |
| --- | --- |
| [`limit_tape_live.ex`](limit_tape_live.ex) | limit: 3 on stream and insert |
| [`limit_tape_live_test.exs`](limit_tape_live_test.exs) | QNH falls off |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/08-mohe-limit-tape](http://localhost:4000/features/10-streams/08-mohe-limit-tape).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/08-mohe-limit-tape/limit_tape_live_test.exs
```
