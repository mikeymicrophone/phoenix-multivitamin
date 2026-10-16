# Core components and layouts · 11 · Schiphol print ticket

Marshal Saskia prints a pushback ticket for an Embraer E190 off pier E.
The print path nests a local jacket inside `Layouts.catalog`. The catalog
card is the outer desk; the jacket is the inner layout.

**What it teaches**

- Nested layouts are a wrapper around a wrapper.
- `live_action` can pick the inner jacket.
- Scenario names stay in the jacket, not in `layouts.ex`.

**Files**

| File | Role |
| --- | --- |
| [`print_ticket_live.ex`](print_ticket_live.ex) | Catalog card and nested jacket |
| [`print_ticket_live_test.exs`](print_ticket_live_test.exs) | Jacket inside catalog-shell |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/05-core-components-and-layouts/11-schiphol-print-ticket](http://localhost:4000/features/05-core-components-and-layouts/11-schiphol-print-ticket).

```sh
mix test features/05-core-components-and-layouts/11-schiphol-print-ticket/print_ticket_live_test.exs
```
