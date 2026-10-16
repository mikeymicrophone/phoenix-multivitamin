# LiveComponents · 10 · Rankin Inlet myself

Clerk Tapiri stamps a Hawker 800XP cell through @myself, then pings the parent with self().

**What it teaches**

- `@myself` is a CID. `self()` inside the cell is the parent pid.

**Files**

| File | Role |
| --- | --- |
| [`myself_cell.ex`](myself_cell.ex) | Two buttons, two targets |
| [`myself_live.ex`](myself_live.ex) | Parent hears only the ping |
| [`myself_live_test.exs`](myself_live_test.exs) | Stamp stays; ping is heard |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/10-rankin-inlet-myself](http://localhost:4000/features/11-live-components/10-rankin-inlet-myself).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/10-rankin-inlet-myself/myself_live_test.exs
```
