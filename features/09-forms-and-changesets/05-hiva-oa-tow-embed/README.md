# Forms and changesets · 05 · Hiva Oa tow embed

Clerk Heiata nests a lagoon tow inside a Cessna 185 Skywagon card at Hiva Oa.

**What it teaches**

- `embeds_one` plus `<.inputs_for>` puts the nested tow on the form.

**Files**

| File | Role |
| --- | --- |
| [`tow.ex`](tow.ex) | Nested tow embed |
| [`tow_card.ex`](tow_card.ex) | Parent card with cast_embed |
| [`tow_embed_live.ex`](tow_embed_live.ex) | inputs_for the tow |
| [`tow_embed_live_test.exs`](tow_embed_live_test.exs) | Nested names are on the form |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/09-forms-and-changesets/05-hiva-oa-tow-embed](http://localhost:4000/features/09-forms-and-changesets/05-hiva-oa-tow-embed).

Run the test with the rest of the bottle:

```sh
mix test features/09-forms-and-changesets/05-hiva-oa-tow-embed/tow_embed_live_test.exs
```
