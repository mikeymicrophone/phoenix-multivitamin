# Forms and changesets · 02 · Gwadar cargo changeset

Clerk Parveen validates an Antonov An-12 pallet at Gwadar on every keystroke.

**What it teaches**

- `phx-change` runs the changeset on every keystroke.

**Files**

| File | Role |
| --- | --- |
| [`cargo_card.ex`](cargo_card.ex) | Pallet kilogram changeset |
| [`cargo_changeset_live.ex`](cargo_changeset_live.ex) | phx-change validate_pallet |
| [`cargo_changeset_live_test.exs`](cargo_changeset_live_test.exs) | A 9000 kg pallet is rejected |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/02-gwadar-cargo-changeset](http://localhost:4000/features/09-forms-and-changesets/02-gwadar-cargo-changeset).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/02-gwadar-cargo-changeset/cargo_changeset_live_test.exs
```
