# LiveView lifecycle and events · 06 · Tatoosh weather round

Observer Quill logs the weather on Tatoosh Island, off Cape Flattery. The
key desk uses `phx-keydown` with `phx-key` so a browser only sends W, F, or
Enter. LiveViewTest does not honor that filter.

**What it teaches**

- `phx-keydown` sends `handle_event/3` with a `"key"` in the payload.
- `phx-key` is a client-side filter. The browser compares keys
  case-insensitively and drops the rest. LiveViewTest's `render_keydown/2`
  does not apply it, so a stray `"x"` still arrives.
- Pattern-matching `"key"` on the server is how the round ignores a key
  the client should not have sent.

**Files**

| File | Role |
| --- | --- |
| [`weather_round_live.ex`](weather_round_live.ex) | The LiveView: key pads and stray-key handling |
| [`weather_round_live_test.exs`](weather_round_live_test.exs) | LiveViewTest for matching keys and the filter bypass |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/06-tatoosh-weather-round](http://localhost:4000/features/06-liveview-lifecycle-and-events/06-tatoosh-weather-round).
Focus the wind pad and press W.

```sh
mix test features/06-liveview-lifecycle-and-events/06-tatoosh-weather-round/weather_round_live_test.exs
```
