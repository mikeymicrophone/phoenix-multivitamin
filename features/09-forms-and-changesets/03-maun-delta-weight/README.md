# Forms and changesets · 03 · Maun delta weight

Clerk Kagiso stamps a GippsAero GA8 Airvan safari weight at Maun only when the card is valid.

**What it teaches**

- `phx-submit` persists the card only when the changeset is valid.

**Files**

| File | Role |
| --- | --- |
| [`weight_card.ex`](weight_card.ex) | Souls-on-board changeset |
| [`delta_weight_live.ex`](delta_weight_live.ex) | Save stamps a valid card |
| [`delta_weight_live_test.exs`](delta_weight_live_test.exs) | Twelve souls stay off the board |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/03-maun-delta-weight](http://localhost:4000/features/09-forms-and-changesets/03-maun-delta-weight).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/03-maun-delta-weight/delta_weight_live_test.exs
```
