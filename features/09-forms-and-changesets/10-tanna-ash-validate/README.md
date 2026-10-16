# Forms and changesets · 10 · Tanna ash validate

Clerk Leipakoa files Yasur ash for a Britten-Norman BN-2 Islander. Change is :validate. Submit is :insert.

**What it teaches**

- `phx-change` sets changeset action `:validate`. `phx-submit` sets `:insert`.

**Files**

| File | Role |
| --- | --- |
| [`ash_card.ex`](ash_card.ex) | Ash feet changeset |
| [`ash_validate_live.ex`](ash_validate_live.ex) | Two actions on one form |
| [`ash_validate_live_test.exs`](ash_validate_live_test.exs) | Change then submit swap the action |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/10-tanna-ash-validate](http://localhost:4000/features/09-forms-and-changesets/10-tanna-ash-validate).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/10-tanna-ash-validate/ash_validate_live_test.exs
```
