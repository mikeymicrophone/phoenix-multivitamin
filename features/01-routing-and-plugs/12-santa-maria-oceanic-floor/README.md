# Routing and plugs · 12 · Santa Maria oceanic floor

Radio operators along Santa Maria Oceanic nest a station inside the FIR and a watch
inside the station. Santa Maria's evening watch is
`/station/santa-maria/watch/evening/floor`. Nested `pipe_through` is
additive: the oceanic plug runs, then the watch plug. The relief radio is a
sibling scope with only the watch plug, so it never stamps the FIR.
Path params stay strings.

**What it teaches**

- Nested `scope` blocks concatenate prefixes, including dynamic segments.
- Nested `pipe_through` accumulates. The child still runs the parent plugs.
- A sibling scope does not inherit a cousin's pipeline.
- Scope path params arrive as strings (`"santa-maria"`, `"evening"`).

**Files**

| File | Role |
| --- | --- |
| [`watch_floor_live.ex`](watch_floor_live.ex) | Catalog page |
| [`oceanic_plug.ex`](oceanic_plug.ex) | Parent pipeline plug |
| [`watch_plug.ex`](watch_plug.ex) | Nested pipeline plug |
| [`watch_floor_controller.ex`](watch_floor_controller.ex) | Nested floor and the relief radio |
| [`watch_floor_html.ex`](watch_floor_html.ex) | The watch board |
| [`watch_floor_test.exs`](watch_floor_test.exs) | Additive vs sibling pipelines |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/12-santa-maria-oceanic-floor](http://localhost:4000/features/01-routing-and-plugs/12-santa-maria-oceanic-floor).

```sh
mix test features/01-routing-and-plugs/12-santa-maria-oceanic-floor/watch_floor_test.exs
```
