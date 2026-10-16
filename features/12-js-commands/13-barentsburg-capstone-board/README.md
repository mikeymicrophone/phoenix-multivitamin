# JS commands · 13 · Barentsburg capstone board

Clerk Lars toggles the Grumant drawer, fades the lamp, and pushes a log on a Eurocopter AS332 Super Puma board.

**What it teaches**

- Capstone: toggle, push, and a transition on one board.

**Files**

| File | Role |
| --- | --- |
| [`capstone_board_live.ex`](capstone_board_live.ex) | toggle |> transition |> push |
| [`capstone_board_live_test.exs`](capstone_board_live_test.exs) | The server logs Grumant open |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/13-barentsburg-capstone-board](http://localhost:4000/features/12-js-commands/13-barentsburg-capstone-board).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/13-barentsburg-capstone-board/capstone_board_live_test.exs
```
