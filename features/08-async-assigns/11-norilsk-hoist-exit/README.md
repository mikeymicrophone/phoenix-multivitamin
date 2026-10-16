# Async assigns · 11 · Norilsk hoist exit

Clerk Gavril starts a hoist on a Mil Mi-26 at Norilsk. The async process
exits `:hoist_cable_snap`. Because it is linked, the LiveView exits too.

**What it teaches**

- `Process.exit/2` inside `assign_async` is linked to the LiveView.
- The LiveView exits with `:hoist_cable_snap`; it is not a failed assign.

**Files**

| File | Role |
| --- | --- |
| [`hoist_exit_live.ex`](hoist_exit_live.ex) | Process.exit inside assign_async |
| [`hoist_exit_live_test.exs`](hoist_exit_live_test.exs) | Dead render lives; live/2 exits |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/11-norilsk-hoist-exit](http://localhost:4000/features/08-async-assigns/11-norilsk-hoist-exit).

```sh
mix test features/08-async-assigns/11-norilsk-hoist-exit/hoist_exit_live_test.exs
```
