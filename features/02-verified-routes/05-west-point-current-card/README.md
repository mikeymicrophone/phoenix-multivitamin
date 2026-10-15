# Verified routes · 05 · West Point current card

Keeper Ivo posts the current off West Point Light at Discovery Park. The
drift calculator is a controller action. It does not render a page; it
`redirect(to: ~p"...")` onto the current card with set and knots in the
query.

**What it teaches**

- `redirect(conn, to: ~p"/card?#{[set: "ebb", knots: "1.4"]}")` is a
  verified path. The controller never builds the URL with `<>`.
- `redirected_to/1` in ConnTest sees the same string `~p` produced,
  including sorted query keys.
- The LiveView still owns the card. `handle_params/3` reads the query
  the controller verified.

**Files**

| File | Role |
| --- | --- |
| [`current_card_controller.ex`](current_card_controller.ex) | Drift calculator: redirect with ~p |
| [`current_card_live.ex`](current_card_live.ex) | The current card LiveView |
| [`current_card_live_test.exs`](current_card_live_test.exs) | Redirect target and the card query |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/05-west-point-current-card](http://localhost:4000/features/02-verified-routes/05-west-point-current-card).
Run the drift calculator. The card comes back on ebb at 1.4 kn.

```sh
mix test features/02-verified-routes/05-west-point-current-card/current_card_live_test.exs
```
