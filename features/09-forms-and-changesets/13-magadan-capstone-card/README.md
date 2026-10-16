# Forms and changesets · 13 · Magadan capstone card

Clerk Stepan live-validates a nested Antonov An-124 fuel and payload card and writes it at Magadan.

**What it teaches**

- Live validation, nested fields, and a save that writes.
- `Repo.insert/1` stores the card and the payload embed.

**Files**

| File | Role |
| --- | --- |
| [`payload.ex`](payload.ex) | Nested cargo and souls |
| [`fuel_card.ex`](fuel_card.ex) | Repo schema |
| [`capstone_card_live.ex`](capstone_card_live.ex) | Validate, nest, write |
| [`capstone_card_live_test.exs`](capstone_card_live_test.exs) | Invalid litres; then a Repo row |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/13-magadan-capstone-card](http://localhost:4000/features/09-forms-and-changesets/13-magadan-capstone-card).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/13-magadan-capstone-card/capstone_card_live_test.exs
```
