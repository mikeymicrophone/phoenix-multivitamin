# Function components and HEEx · 09 · Discovery Bay tile board

Ione fires encaustic tiles at Discovery Bay. Three chips share a glaze. One
writes its firing pass with `Map.put/3`, one with `Phoenix.Component.assign/3`,
and one is never told the kiln temperature.

**What it teaches**

- HEEx change tracking looks at `__changed__`. `assign/3` marks a key. `Map.put/3`
  does not, so `{@fired_pass}` on the Map.put chip stays on the first pass
  even while `{@kiln_temp}` updates.
- Raising the kiln re-renders chips that received `kiln_temp`. The quiet chip
  is not passed that assign, so its firing pass stays put until the glaze
  itself changes.
- Dipping copper rutile changes `:glaze`, which every chip was passed, so all
  three update — including the quiet chip's pass, because `assign/3` runs again.

**Files**

| File | Role |
| --- | --- |
| [`tile_board_live.ex`](tile_board_live.ex) | LiveView and the three chips |
| [`tile_board_live_test.exs`](tile_board_live_test.exs) | LiveViewTest for Map.put vs assign vs skip |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/09-discovery-bay-tile-board](http://localhost:4000/features/04-function-components-and-heex/09-discovery-bay-tile-board).
Raise the kiln. Dip copper rutile. Watch which firing passes move.

```sh
mix test features/04-function-components-and-heex/09-discovery-bay-tile-board/tile_board_live_test.exs
```
