# Routing and plugs · 08 · Finkenwerder jig floor

Jig clerk Anke posts join cards at Airbus Finkenwerder in
Hamburg: the A321neo wingbox in wing jig 12, rear section 19 in fuse jig 4,
pax door C in door jig 3. The floor ledger is the `:browser` pipeline (HTML).
The lab feed is the `:api` pipeline (JSON). One controller serves both. Asking
the API for `text/html` is a 406.

**What it teaches**

- Sibling pipelines can share a controller and split formats.
- `plug :accepts, ["json"]` sets the format from the Accept header.
- A mismatched Accept never reaches the jig ledger; Phoenix sends 406.

**Files**

| File | Role |
| --- | --- |
| [`jig_floor_live.ex`](jig_floor_live.ex) | Catalog page |
| [`jig_floor_controller.ex`](jig_floor_controller.ex) | HTML and JSON from `get_format/1` |
| [`jig_floor_html.ex`](jig_floor_html.ex) | Floor ledger |
| [`jig_floor_test.exs`](jig_floor_test.exs) | HTML, JSON, and 406 |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/08-finkenwerder-jig-floor](http://localhost:4000/features/01-routing-and-plugs/08-finkenwerder-jig-floor).

```sh
mix test features/01-routing-and-plugs/08-finkenwerder-jig-floor/jig_floor_test.exs
```
