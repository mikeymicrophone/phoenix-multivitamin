# LiveComponents · 09 · Bumthang nest card

Clerk Dechen nests a valley cell inside a Xian MA60 outer card.

**What it teaches**

- A LiveComponent may render another LiveComponent.

**Files**

| File | Role |
| --- | --- |
| [`inner_cell.ex`](inner_cell.ex) | Valley plate |
| [`outer_cell.ex`](outer_cell.ex) | Nests the inner cell |
| [`nest_card_live.ex`](nest_card_live.ex) | Parent mounts the outer card |
| [`nest_card_live_test.exs`](nest_card_live_test.exs) | Chhume is inside the outer card |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/09-bumthang-nest-card](http://localhost:4000/features/11-live-components/09-bumthang-nest-card).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/09-bumthang-nest-card/nest_card_live_test.exs
```
