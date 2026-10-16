# Function components and HEEx · 07 · Hahnweide work cards

Jutta rigs a Bücker Jungmann at Hahnweide. The work card yields the current
bay — timber, siding, name — into `:let`. A second card calls
`render_slot/1` with no argument, so `:let` is `nil`. Dope is an optional
named slot with a shop-floor fallback.

**What it teaches**

- `render_slot(@inner_block, @station)` is what `:let={station}` receives.
- `render_slot(@inner_block)` without a second argument binds `nil` to `:let`.
- `render_slot(@dope) || "No dope scheduled this week."` runs the
  fallback when the optional slot is empty (`[]` → `nil`).

**Files**

| File | Role |
| --- | --- |
| [`work_card_live.ex`](work_card_live.ex) | LiveView and the `work_card/1` component |
| [`work_card_live_test.exs`](work_card_live_test.exs) | LiveViewTest for yield, nil, and fallback |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/07-hahnweide-work-cards](http://localhost:4000/features/04-function-components-and-heex/07-hahnweide-work-cards).
Move to the leading-edge. Skip the dope note.

```sh
mix test features/04-function-components-and-heex/07-hahnweide-work-cards/work_card_live_test.exs
```
