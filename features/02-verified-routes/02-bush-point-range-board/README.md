# Verified routes · 02 · Bush Point range board

Keeper Ned lines up the Bush Point range lights for Admiralty Inlet. Front
and rear, plus a true bearing, ride in the query string inside `~p`, not
stitched on with `<>`.

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
| [`range_board_live.ex`](range_board_live.ex) | The LiveView: front/rear query paths |
| [`range_board_live_test.exs`](range_board_live_test.exs) | Encoding, sorting, and the patch |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/02-bush-point-range-board](http://localhost:4000/features/02-verified-routes/02-bush-point-range-board).
Switch to the rear range. The URL picks up `bearing` and `light`.

```sh
mix test features/02-verified-routes/02-bush-point-range-board/range_board_live_test.exs
```
