# Async assigns · 03 · Quetta ok board

Clerk Zarmina waits for QNH on an Ilyushin Il-18 at Quetta. The `{:ok, %{qnh: 1019}}` tuple fills the board.

**What it teaches**

- The ok tuple fills the assign result.
- `@qnh.ok?` is the gate the board reads.

**Files**

| File | Role |
| --- | --- |
| [`ok_board_live.ex`](ok_board_live.ex) | ok tuple into QNH |
| [`ok_board_live_test.exs`](ok_board_live_test.exs) | pending then 1019 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/08-async-assigns/03-quetta-ok-board](http://localhost:4000/features/08-async-assigns/03-quetta-ok-board).

```sh
mix test features/08-async-assigns/03-quetta-ok-board/ok_board_live_test.exs
```
