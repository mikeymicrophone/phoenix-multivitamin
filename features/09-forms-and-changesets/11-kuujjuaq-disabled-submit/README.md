# Forms and changesets · 11 · Kuujjuaq disabled submit

Clerk Elisapie cannot stamp a Hawker Siddeley HS 748 ice card at Kuujjuaq until the millimetres are valid.

**What it teaches**

- The submit button stays `disabled` until the changeset is valid.

**Files**

| File | Role |
| --- | --- |
| [`ice_card.ex`](ice_card.ex) | Ice millimetre changeset |
| [`disabled_submit_live.ex`](disabled_submit_live.ex) | Disabled until valid |
| [`disabled_submit_live_test.exs`](disabled_submit_live_test.exs) | Twelve millimetres enable the stamp |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/11-kuujjuaq-disabled-submit](http://localhost:4000/features/09-forms-and-changesets/11-kuujjuaq-disabled-submit).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/11-kuujjuaq-disabled-submit/disabled_submit_live_test.exs
```
