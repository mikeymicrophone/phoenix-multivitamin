# Verified routes · 01 · Alki Point signal flags

Keeper Rhea hoists storm signals over Elliott Bay from Alki Point Light.
The day board and the night board are two compile-time `~p` paths on the
same LiveView, not strings glued together.

**What it teaches**

- `~p"/path"` is checked against the router when the module compiles. A typo
  in a static segment is a warning, not a 404 at runtime.
- `<.link navigate={~p"..."}>` consumes the sigil the same way a controller
  redirect would. The href in the HTML is the verified string.
- A second static path (`/night`) is a different verified route, even when
  it points at the same LiveView with a `live_action`.
- Named functions such as `day_board_path/0` that return `~p` keep the path
  in one place without bringing back router helpers.

**Files**

| File | Role |
| --- | --- |
| [`signal_flags_live.ex`](signal_flags_live.ex) | The LiveView: day and night boards, hoist buttons |
| [`signal_flags_live_test.exs`](signal_flags_live_test.exs) | ConnTest and LiveViewTest for both verified paths |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/01-alki-point-signal-flags](http://localhost:4000/features/02-verified-routes/01-alki-point-signal-flags).
Hoist storm. Switch to the night board.

```sh
mix test features/02-verified-routes/01-alki-point-signal-flags/signal_flags_live_test.exs
```
