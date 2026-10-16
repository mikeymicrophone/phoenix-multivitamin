# LiveComponents · 11 · Lae assign split

Clerk Kila owns the Fokker F27 pad. The cell owns its taps. A pad swing does not reset the taps.

**What it teaches**

- Parent assigns flow in through `update/2`. Child assigns survive that update.

**Files**

| File | Role |
| --- | --- |
| [`split_cell.ex`](split_cell.ex) | Owns taps |
| [`assign_split_live.ex`](assign_split_live.ex) | Owns the pad |
| [`assign_split_live_test.exs`](assign_split_live_test.exs) | South pad, taps still 1 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/11-lae-assign-split](http://localhost:4000/features/11-live-components/11-lae-assign-split).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/11-lae-assign-split/assign_split_live_test.exs
```
