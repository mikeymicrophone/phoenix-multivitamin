# LiveView lifecycle and events · 09 · Juist windsock book

Marshal Hilde works the windsock at Juist Airfield, before the Twin Otter
rolls. Starting the socks does `send(self(), :strike_sock)`. The strike is
the next mailbox message, after that click has already rendered. Later
strikes use `Process.send_after/3` at one minute.

**What it teaches**

- `send(self(), msg)` from `handle_event/3` is handled in `handle_info/2`.
- That `handle_info/2` runs after the event's render. The HTML returned by
  `render_click/1` does not yet include the strike. `:sys.get_state/1`
  waits until the LiveView is idle, then the tally is 1.
- `Process.send_after/3` schedules the next strike only while the sock is
  running. Stopping the sock leaves a late message harmless because the
  flag is false.

**Files**

| File | Role |
| --- | --- |
| [`windsock_book_live.ex`](windsock_book_live.ex) | The LiveView: start/stop and the strike mailbox |
| [`windsock_book_live_test.exs`](windsock_book_live_test.exs) | LiveViewTest for event-then-info ordering |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/09-juist-windsock-book](http://localhost:4000/features/06-liveview-lifecycle-and-events/09-juist-windsock-book).
Start the socks. The first strike posts immediately; the next waits a minute.

```sh
mix test features/06-liveview-lifecycle-and-events/09-juist-windsock-book/windsock_book_live_test.exs
```
