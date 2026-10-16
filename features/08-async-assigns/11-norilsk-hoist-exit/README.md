# Async assigns · 11 · Norilsk hoist exit

Clerk Gavril starts a hoist on a Mil Mi-26 at Norilsk. The async process exits `:hoist_cable_snap`. The LiveView stays up and paints the reason.

**What it teaches**

- An async function that exits fails the assign.
- The failed reason is `{:exit, :hoist_cable_snap}`.

**Files**

| File | Role |
| --- | --- |
| [`hoist_exit_live.ex`](hoist_exit_live.ex) | Process.exit inside assign_async |
| [`hoist_exit_live_test.exs`](hoist_exit_live_test.exs) | Failed reason, LiveView still mounted |

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
