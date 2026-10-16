# Verified routes · 05 · Funchal wind card

ATCO Rui posts the wind off Funchal for the Airbus A330. The drift
calculator is a controller action. It does not render a page; it
`redirect(to: ~p"...")` onto the wind card with set and knots in the
query.

**What it teaches**

- `redirect(conn, to: ~p"/card?#{[set: "cross", knots: "18"]}")` is a
  verified path. The controller never builds the URL with `<>`.
- `redirected_to/1` in ConnTest sees the same string `~p` produced,
  including sorted query keys.
- The LiveView still owns the card. `handle_params/3` reads the query
  the controller verified.

**Files**

| File | Role |
| --- | --- |
| [`wind_card_controller.ex`](wind_card_controller.ex) | Drift calculator: redirect with ~p |
| [`wind_card_live.ex`](wind_card_live.ex) | The wind card LiveView |
| [`wind_card_live_test.exs`](wind_card_live_test.exs) | Redirect target and the card query |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/05-funchal-wind-card](http://localhost:4000/features/02-verified-routes/05-funchal-wind-card).
Run the drift calculator. The card comes back on cross at 18 kn.

```sh
mix test features/02-verified-routes/05-funchal-wind-card/wind_card_live_test.exs
```
