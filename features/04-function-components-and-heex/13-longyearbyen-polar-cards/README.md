# Function components and HEEx · 13 · Longyearbyen polar cards

Toril counts A320ceo turns on the Longyearbyen apron in Svalbard. Each
on-stand bay is a card: attrs, a `:let` note, named `:pass` slots that
render turn chips, an optional watch slot, rest for `data-crest`, and a
class list that follows ice stage. Stand C is hangared and stays off the
sheet.

**What it teaches**

- One press sheet uses attr, slot, `:for` / `:if` / `:let` / `:key`, rest,
  class lists, and a child `turn_chip/1`.
- `:if={panel.on_stand?}` omits stand C. `:if={pass.count > 0}` omits a zero
  tech count on stand A.
- `render_slot(@inner_block, @panel)` yields the panel into `:let`. The
  watch slot falls back when stand B has no night ops.
- Rest carries `data-crest`. Packed ice adds a class without rewriting the
  card.

**Files**

| File | Role |
| --- | --- |
| [`polar_card_live.ex`](polar_card_live.ex) | LiveView and the nested polar card / chip |
| [`polar_card_live_test.exs`](polar_card_live_test.exs) | LiveViewTest for the capstone sheet |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/13-longyearbyen-polar-cards](http://localhost:4000/features/04-function-components-and-heex/13-longyearbyen-polar-cards).
Pack the ice. Lift stand B.

```sh
mix test features/04-function-components-and-heex/13-longyearbyen-polar-cards/polar_card_live_test.exs
```
