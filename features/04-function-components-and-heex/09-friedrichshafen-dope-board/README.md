# Function components and HEEx · 09 · Friedrichshafen dope board

Klara dopes Zeppelin NT fabric at Friedrichshafen. Three chips share a
tint. One writes its firing pass with `Map.put/3`, one with
`Phoenix.Component.assign/3`, and one is never told the loft temperature.

**What it teaches**

- HEEx change tracking looks at `__changed__`. `assign/3` marks a key. `Map.put/3`
  does not, so `{@fired_pass}` on the Map.put chip stays on the first pass
  even while `{@loft_temp}` updates.
- Raising the loft re-renders chips that received `loft_temp`. The quiet chip
  is not passed that assign, so its firing pass stays put until the tint
  itself changes.
- Dipping aluminium pigment changes `:tint`, which every chip was passed, so all
  three update — including the quiet chip's pass, because `assign/3` runs again.

**Files**

| File | Role |
| --- | --- |
| [`dope_board_live.ex`](dope_board_live.ex) | LiveView and the three chips |
| [`dope_board_live_test.exs`](dope_board_live_test.exs) | LiveViewTest for Map.put vs assign vs skip |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/09-friedrichshafen-dope-board](http://localhost:4000/features/04-function-components-and-heex/09-friedrichshafen-dope-board).
Raise the loft. Dip aluminium pigment. Watch which firing passes move.

```sh
mix test features/04-function-components-and-heex/09-friedrichshafen-dope-board/dope_board_live_test.exs
```
