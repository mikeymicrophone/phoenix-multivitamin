# LiveComponents · 04 · Khorog parent ping

Clerk Faridun pings the parent from a PZL M-28 cell. The ridge lands on the LiveView.

**What it teaches**

- `send(self(), msg)` from the child is the parent LiveView process.

**Files**

| File | Role |
| --- | --- |
| [`ping_cell.ex`](ping_cell.ex) | send/2 the ridge |
| [`parent_ping_live.ex`](parent_ping_live.ex) | handle_info paints the ridge |
| [`parent_ping_live_test.exs`](parent_ping_live_test.exs) | Gunt ridge appears on the parent |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/04-khorog-parent-ping](http://localhost:4000/features/11-live-components/04-khorog-parent-ping).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/04-khorog-parent-ping/parent_ping_live_test.exs
```
