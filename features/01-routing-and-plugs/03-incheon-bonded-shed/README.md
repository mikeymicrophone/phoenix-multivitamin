# Routing and plugs · 03 · Incheon bonded shed

Inspector Haneul keeps two ledgers in the Incheon bonded shed.
Arrivals off Narita (the KE pallet run, ULD train 17) and departures toward
Xi'an (OZ re-export van, Hanjin late pallet) share one controller.
Sibling scopes pipe through the same inspector plug with a different `lane`
option. `resources/4` draws index and show under each prefix.

**What it teaches**

- Sibling `scope` blocks share a controller and split a plug stack.
- `resources/4` with `only: [:index, :show]` draws REST routes under each
  prefix.
- Path params are strings. ULD train `"17"` is not an integer.

**Files**

| File | Role |
| --- | --- |
| [`bonded_shed_live.ex`](bonded_shed_live.ex) | Catalog page with links onto both ledgers |
| [`inspector_plug.ex`](inspector_plug.ex) | Module plug that stamps lane, shed, and inspector |
| [`declarations_controller.ex`](declarations_controller.ex) | Index and show for both lanes |
| [`declarations_html.ex`](declarations_html.ex) | Ledgers and a single declaration |
| [`bonded_shed_test.exs`](bonded_shed_test.exs) | Arrivals vs departures, and string ids |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/03-incheon-bonded-shed](http://localhost:4000/features/01-routing-and-plugs/03-incheon-bonded-shed).

```sh
mix test features/01-routing-and-plugs/03-incheon-bonded-shed/bonded_shed_test.exs
```
