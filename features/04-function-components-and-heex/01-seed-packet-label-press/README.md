# Function components and HEEx · 01 · Seed packet label press

Linnea runs the Heidelberg platen at Nash's Organic Produce in Sequim. Each
seed packet is a function component: Chioggia beet, Des Moines lima, and
Winter Density lettuce. Required attrs are the variety and lot. Weight, kind,
and the organic claim have defaults. Kind is an atom limited by `values:`.

**What it teaches**

- `attr/3` declares types (`:string`, `:integer`, `:atom`, `:boolean`).
- `required: true` marks variety, lot, and the DOM id. `default:` fills grams
  (3 g), kind (`:heirloom`), and `organic?` (true) when the caller omits them.
- `values: [:heirloom, :open_pollinated, :hybrid]` is the exhaustive list for
  `kind`. The platen can stamp Chioggia as hybrid without touching the lima.
- Passing `grams={nil}` does **not** restore the default. The lima scale reads
  empty until the operator restores a number.

**Files**

| File | Role |
| --- | --- |
| [`seed_packet_live.ex`](seed_packet_live.ex) | LiveView and the `packet_label/1` component |
| [`seed_packet_live_test.exs`](seed_packet_live_test.exs) | LiveViewTest for defaults, values, and nil |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/04-function-components-and-heex/01-seed-packet-label-press](http://localhost:4000/features/04-function-components-and-heex/01-seed-packet-label-press).
Stamp Chioggia as hybrid. Clear the lima scale.

```sh
mix test features/04-function-components-and-heex/01-seed-packet-label-press/seed_packet_live_test.exs
```
