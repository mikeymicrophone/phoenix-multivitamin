# Routing and plugs · 12 · Rosario watch floor

Keepers along Rosario Strait nest a station inside the strait and a watch
inside the station. Lime Kiln's evening watch is
`/station/lime-kiln/watch/evening/floor`. Nested `pipe_through` is
additive: the strait plug runs, then the watch plug. The relief boat is a
sibling scope with only the watch plug, so it never stamps the strait.
Path params stay strings.

**What it teaches**

- Nested `scope` blocks concatenate prefixes, including dynamic segments.
- Nested `pipe_through` accumulates. The child still runs the parent plugs.
- A sibling scope does not inherit a cousin's pipeline.
- Scope path params arrive as strings (`"lime-kiln"`, `"evening"`).

**Files**

| File | Role |
| --- | --- |
| [`watch_floor_live.ex`](watch_floor_live.ex) | Catalog page |
| [`strait_plug.ex`](strait_plug.ex) | Parent pipeline plug |
| [`watch_plug.ex`](watch_plug.ex) | Nested pipeline plug |
| [`watch_floor_controller.ex`](watch_floor_controller.ex) | Nested floor and the relief boat |
| [`watch_floor_html.ex`](watch_floor_html.ex) | The watch board |
| [`watch_floor_test.exs`](watch_floor_test.exs) | Additive vs sibling pipelines |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/12-rosario-watch-floor](http://localhost:4000/features/01-routing-and-plugs/12-rosario-watch-floor).

```sh
mix test features/01-routing-and-plugs/12-rosario-watch-floor/watch_floor_test.exs
```
