# Controllers and JSON · 10 · Leh density-altitude card

Engineer Tenzin computes takeoff for an Antonov An-32 at Kushok Bakula
Rimpochee, 10,682 ft above the Indus. The post is nested under `card`.
`create/2` pattern-matches `%{"card" => %{...}}`. A flat map misses that
clause and returns 422.

**What it teaches**

- Params nested under a domain key match a specific clause.
- A flat map does not.
- The action reads `oat_c` and `elevation_ft` from inside `card`.

**Files**

| File | Role |
| --- | --- |
| [`density_altitude_card_live.ex`](density_altitude_card_live.ex) | Catalog page |
| [`density_altitude_card_controller.ex`](density_altitude_card_controller.ex) | Nested versus flat create |
| [`density_altitude_card_html.ex`](density_altitude_card_html.ex) | Empty card board |
| [`density_altitude_card_test.exs`](density_altitude_card_test.exs) | Nested 201 versus flat 422 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/03-controllers-and-json/10-leh-density-altitude-card](http://localhost:4000/features/03-controllers-and-json/10-leh-density-altitude-card).

```sh
mix test features/03-controllers-and-json/10-leh-density-altitude-card/density_altitude_card_test.exs
```
