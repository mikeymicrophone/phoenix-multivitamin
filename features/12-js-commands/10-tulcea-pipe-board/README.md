# JS commands · 10 · Tulcea pipe board

Clerk Doina pipes show, class, and push for a Saab 2000 delta card.

**What it teaches**

- Commands compose with `|>` on one `phx-click`.

**Files**

| File | Role |
| --- | --- |
| [`pipe_board_live.ex`](pipe_board_live.ex) | show |> add_class |> push |
| [`pipe_board_live_test.exs`](pipe_board_live_test.exs) | The server marks lit |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/12-js-commands/10-tulcea-pipe-board](http://localhost:4000/features/12-js-commands/10-tulcea-pipe-board).

Run the test with the rest of the bottle:

```sh
mix test features/12-js-commands/10-tulcea-pipe-board/pipe_board_live_test.exs
```
