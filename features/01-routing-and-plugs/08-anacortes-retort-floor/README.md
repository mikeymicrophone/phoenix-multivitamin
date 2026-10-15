# Routing and plugs · 08 · Anacortes retort floor

Floor boss Veda posts cook cards at the Pacific American Cannery in
Anacortes: sockeye halves in retort 12, pink talls in retort 4, razor clams
in retort 3. The floor ledger is the `:browser` pipeline (HTML). The lab
feed is the `:api` pipeline (JSON). One controller serves both. Asking the
API for `text/html` is a 406.

**What it teaches**

- Sibling pipelines can share a controller and split formats.
- `plug :accepts, ["json"]` sets the format from the Accept header.
- A mismatched Accept never reaches the cook ledger; Phoenix sends 406.

**Files**

| File | Role |
| --- | --- |
| [`retort_floor_live.ex`](retort_floor_live.ex) | Catalog page |
| [`retort_floor_controller.ex`](retort_floor_controller.ex) | HTML and JSON from `get_format/1` |
| [`retort_floor_html.ex`](retort_floor_html.ex) | Floor ledger |
| [`retort_floor_test.exs`](retort_floor_test.exs) | HTML, JSON, and 406 |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/08-anacortes-retort-floor](http://localhost:4000/features/01-routing-and-plugs/08-anacortes-retort-floor).

```sh
mix test features/01-routing-and-plugs/08-anacortes-retort-floor/retort_floor_test.exs
```
