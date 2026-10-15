# Function components and HEEx · 13 · Skokomish weir cards

Elsie counts the night passage at the Skokomish River weir off Twana Road.
Each in-water panel is a card: attrs, a `:let` note, named `:pass` slots that
render species chips, an optional watch slot, rest for `data-crest`, and a
class list that follows flood stage. Panel C is on dry gravel and stays off
the sheet.

**What it teaches**

- One press sheet uses attr, slot, `:for` / `:if` / `:let` / `:key`, rest,
  class lists, and a child `species_chip/1`.
- `:if={panel.in_water?}` omits panel C. `:if={pass.count > 0}` omits a zero
  pink count on panel A.
- `render_slot(@inner_block, @panel)` yields the panel into `:let`. The
  watch slot falls back when panel B has no night watch.
- Rest carries `data-crest`. Flood stage adds a class without rewriting the
  card.

**Files**

| File | Role |
| --- | --- |
| [`weir_card_live.ex`](weir_card_live.ex) | LiveView and the nested weir card / chip |
| [`weir_card_live_test.exs`](weir_card_live_test.exs) | LiveViewTest for the capstone sheet |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/13-skokomish-weir-cards](http://localhost:4000/features/04-function-components-and-heex/13-skokomish-weir-cards).
Put the river in flood. Lift panel B.

```sh
mix test features/04-function-components-and-heex/13-skokomish-weir-cards/weir_card_live_test.exs
```
