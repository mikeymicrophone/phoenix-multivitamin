# Verified routes · 11 · Mukilteo fare banner

Clerk Ysolde hangs the fare banner at the Mukilteo ferry terminal. Phoenix
1.8 routers set `helpers: false`, so `Router.Helpers` is never generated.
`fare_board_path/0` and `vehicle_lane_path/1` wrap `~p` instead.

**What it teaches**

- `use Phoenix.Router, helpers: false` (set in `phoenix_multivitamin_web.ex`)
  means `PhoenixMultivitaminWeb.Router.Helpers` does not exist.
  `fare_board_path(conn, :index)` is not coming back.
- A plain Elixir function that returns `~p"/path"` is the replacement.
  The name is for readers; the sigil is still compile-checked.
- Interpolation belongs in those functions:
  `vehicle_lane_path(lane)` returns `~p".../lanes/#{lane}"`. Callers never
  concatenate.
- The LiveView template calls the functions, so a later path change is
  one edit.

**Files**

| File | Role |
| --- | --- |
| [`fare_banner_live.ex`](fare_banner_live.ex) | Banner, named wrappers, lane routes |
| [`fare_banner_live_test.exs`](fare_banner_live_test.exs) | Helpers gone, wrappers, navigation |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/11-mukilteo-fare-banner](http://localhost:4000/features/02-verified-routes/11-mukilteo-fare-banner).
Open lane 2. The URL is the named function's `~p`.

```sh
mix test features/02-verified-routes/11-mukilteo-fare-banner/fare_banner_live_test.exs
```
