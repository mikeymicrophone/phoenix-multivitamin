# Routing and plugs · 13 · Ushuaia austral pipeline

Clerk Pilar stands the Ushuaia austral board on Tierra del Fuego. The austral
board is an outer pipeline. Martial glacier is `forward/2`ed behind ticket
`austral-clear`. Without it, the lookout plug halts at 403 after the austral
plug has already stamped. With it, nested `resources` list Pilar's and
Mateo's watches. The icing glass is a more specific route declared before
`resources`, so `/watches/icing` is not swallowed as an `:id`. An ATR 42
holds short of runway 07 while the lookout talks.

**What it teaches**

- Capstone: outer pipeline, `forward/2`, `halt/1`, nested scopes, and
  `resources/4` on one headland.
- Parent pipelines run before a forwarded router. The austral stamp is on
  the denied lookout page.
- A specific `get` declared before `resources` wins over `:id`.
- Nested path params (`clerk`, `id`) stay strings.

**Files**

| File | Role |
| --- | --- |
| [`pipeline_live.ex`](pipeline_live.ex) | Catalog page |
| [`austral_plug.ex`](austral_plug.ex) | Outer pipeline plug |
| [`lookout_plug.ex`](lookout_plug.ex) | Inner halt on a missing ticket |
| [`lookout_router.ex`](lookout_router.ex) | Forwarded router, icing route, resources |
| [`pipeline_controller.ex`](pipeline_controller.ex) | Outer austral board |
| [`lookout_controller.ex`](lookout_controller.ex) | Desk and icing glass |
| [`watch_controller.ex`](watch_controller.ex) | Nested watches |
| [`pipeline_test.exs`](pipeline_test.exs) | Austral, halt, forward, resources, icing |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/13-ushuaia-austral-pipeline](http://localhost:4000/features/01-routing-and-plugs/13-ushuaia-austral-pipeline).

```sh
mix test features/01-routing-and-plugs/13-ushuaia-austral-pipeline/pipeline_test.exs
```
