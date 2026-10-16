# Verified routes · 02 · Innsbruck approach board

ATCO Lena lines up the Embraer 195 on the Innsbruck approach. Inner and
outer markers, plus an inbound radial, ride in the query string inside
`~p`, not stitched on with `<>`.

**What it teaches**

- `~p"/path?#{query}"` encodes a keyword list or a map. Do not concatenate
  `"?" <> query` onto a verified path.
- With `sort_verified_routes_query_params: true` (set in `config/test.exs`),
  keys come out sorted so `assert_patch/2` does not depend on write order.
- Spaces become `+`. An empty query is a bare path: no trailing `?`.
- `handle_params/3` reads the same query the sigil wrote. `push_patch/2`
  can take the verified string as `to:`.

**Files**

| File | Role |
| --- | --- |
| [`approach_board_live.ex`](approach_board_live.ex) | The LiveView: inner/outer query paths |
| [`approach_board_live_test.exs`](approach_board_live_test.exs) | Encoding, sorting, and the patch |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/02-innsbruck-approach-board](http://localhost:4000/features/02-verified-routes/02-innsbruck-approach-board).
Switch to the outer marker. The URL picks up `radial` and `loc`.

```sh
mix test features/02-verified-routes/02-innsbruck-approach-board/approach_board_live_test.exs
```
