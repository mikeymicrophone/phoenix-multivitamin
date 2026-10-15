# LiveView lifecycle and events · 09 · Slip Point bell book

Keeper Willa works the fog bell at Slip Point Light, on Clallam Bay.
Starting the bells does `send(self(), :strike_bell)`. The strike is the
next mailbox message, after that click has already rendered. Later strikes
use `Process.send_after/3` at one minute.

**What it teaches**

- `send(self(), msg)` from `handle_event/3` is handled in `handle_info/2`.
- That `handle_info/2` runs after the event's render. The HTML returned by
  `render_click/1` does not yet include the strike. `:sys.get_state/1`
  waits until the LiveView is idle, then the tally is 1.
- `Process.send_after/3` schedules the next strike only while the bell is
  running. Stopping the bell leaves a late message harmless because the
  flag is false.

**Files**

| File | Role |
| --- | --- |
| [`bell_book_live.ex`](bell_book_live.ex) | The LiveView: start/stop and the strike mailbox |
| [`bell_book_live_test.exs`](bell_book_live_test.exs) | LiveViewTest for event-then-info ordering |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/09-slip-point-bell-book](http://localhost:4000/features/06-liveview-lifecycle-and-events/09-slip-point-bell-book).
Start the bells. The first strike posts immediately; the next waits a minute.

```sh
mix test features/06-liveview-lifecycle-and-events/09-slip-point-bell-book/bell_book_live_test.exs
```
