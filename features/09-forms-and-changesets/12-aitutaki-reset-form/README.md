# Forms and changesets · 12 · Aitutaki reset form

Clerk Moana files an Embraer EMB-110 Bandeirante lagoon hop at Aitutaki. A successful stamp clears the form.

**What it teaches**

- A valid save replaces the form with a fresh changeset.

**Files**

| File | Role |
| --- | --- |
| [`lagoon_card.ex`](lagoon_card.ex) | Passenger changeset |
| [`reset_form_live.ex`](reset_form_live.ex) | Save then blank_form/0 |
| [`reset_form_live_test.exs`](reset_form_live_test.exs) | Nine passengers stamp and clear |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/12-aitutaki-reset-form](http://localhost:4000/features/09-forms-and-changesets/12-aitutaki-reset-form).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/12-aitutaki-reset-form/reset_form_live_test.exs
```
