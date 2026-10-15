# Function components and HEEx · 07 · Port Hadlock boat shop cards

Kerr lofts a 16-foot Whitehall at the Northwest School of Wooden Boatbuilding
in Port Hadlock. The work card yields the current station — timber, siding,
name — into `:let`. A second card calls `render_slot/1` with no argument, so
`:let` is `nil`. Varnish is an optional named slot with a shop-floor fallback.

**What it teaches**

- `render_slot(@inner_block, @station)` is what `:let={station}` receives.
- `render_slot(@inner_block)` without a second argument binds `nil` to `:let`.
- `render_slot(@varnish) || "No varnish scheduled this week."` runs the
  fallback when the optional slot is empty (`[]` → `nil`).

**Files**

| File | Role |
| --- | --- |
| [`boat_shop_live.ex`](boat_shop_live.ex) | LiveView and the `work_card/1` component |
| [`boat_shop_live_test.exs`](boat_shop_live_test.exs) | LiveViewTest for yield, nil, and fallback |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/07-port-hadlock-boat-shop-cards](http://localhost:4000/features/04-function-components-and-heex/07-port-hadlock-boat-shop-cards).
Move to the stem. Skip the varnish note.

```sh
mix test features/04-function-components-and-heex/07-port-hadlock-boat-shop-cards/boat_shop_live_test.exs
```
