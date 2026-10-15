# LiveView lifecycle and events · 13 · Admiralty Inlet night board

Dispatcher Corin keeps the night board at the Puget Sound Pilot Station,
sending pilots onto Admiralty Inlet. The static render is paper. The
connected process arms the clock with `send(self(), :board_tick)`, posts
inbound and outbound traffic, patches to Nessa on midwatch, and records a
departure in `terminate/2` when the socket leaves.

**What it teaches**

- Capstone: `mount/3`, `handle_params/3`, `handle_event/3`, `handle_info/2`,
  and `terminate/2` on one board.
- `Phoenix.LiveView.Static.render/3` does not spawn a LiveView process. A
  `get/2` never calls `terminate/2`.
- `terminate/2` does run when the connected LiveView process stops. This
  board writes the dispatcher and reason to a departure desk.
- `handle_params/3` switches the watch without remounting. Traffic already
  posted stays; the clock resets to the new watch's start.

**Files**

| File | Role |
| --- | --- |
| [`night_board_live.ex`](night_board_live.ex) | The LiveView: full lifecycle on the night board |
| [`departure_desk.ex`](departure_desk.ex) | An Agent the tests use to read what terminate/2 wrote |
| [`night_board_live_test.exs`](night_board_live_test.exs) | ConnTest for no terminate, LiveViewTest for the rest |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/13-admiralty-inlet-night-board](http://localhost:4000/features/06-liveview-lifecycle-and-events/13-admiralty-inlet-night-board).
Log the Evergreen State inbound, then patch to midwatch.

```sh
mix test features/06-liveview-lifecycle-and-events/13-admiralty-inlet-night-board/night_board_live_test.exs
```
