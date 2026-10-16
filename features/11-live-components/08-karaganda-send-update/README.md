# LiveComponents · 08 · Karaganda send update

Clerk Ayan lifts QNH on a Yakovlev Yak-42 cell with send_update/3. The parent assign stays 1012.

**What it teaches**

- `send_update/3` is the LiveView 1.2 name. `update_component/3` is gone.

**Files**

| File | Role |
| --- | --- |
| [`qnh_cell.ex`](qnh_cell.ex) | update/2 receives the lift |
| [`send_update_live.ex`](send_update_live.ex) | Parent calls send_update/3 |
| [`send_update_live_test.exs`](send_update_live_test.exs) | Cell is 1024; parent stays 1012 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/08-karaganda-send-update](http://localhost:4000/features/11-live-components/08-karaganda-send-update).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/08-karaganda-send-update/send_update_live_test.exs
```
