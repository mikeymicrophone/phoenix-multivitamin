# LiveView lifecycle and events · 07 · Destruction Island relief board

Radio operator Tove copies the relief boat at Destruction Island Light, west
of the Olympic coast. The radio copy field uses `phx-debounce="500"`. The
landing field uses `phx-debounce="blur"`. LiveViewTest posts both immediately.

**What it teaches**

- `phx-debounce="500"` is a client-side delay on `phx-change`. The browser
  waits 500 milliseconds after the last keystroke.
- `phx-debounce="blur"` waits for focus loss instead of a timer.
- `Phoenix.LiveViewTest.render_change/2` talks to the server directly. It
  does not wait, and it does not need a blur. The debounce attributes are
  still in the markup for a real browser.

**Files**

| File | Role |
| --- | --- |
| [`relief_board_live.ex`](relief_board_live.ex) | The LiveView: two debounce styles on the relief board |
| [`relief_board_live_test.exs`](relief_board_live_test.exs) | LiveViewTest proving render_change ignores debounce |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/07-destruction-island-relief-board](http://localhost:4000/features/06-liveview-lifecycle-and-events/07-destruction-island-relief-board).
Type a radio copy and pause; the board should wait half a second.

```sh
mix test features/06-liveview-lifecycle-and-events/07-destruction-island-relief-board/relief_board_live_test.exs
```
