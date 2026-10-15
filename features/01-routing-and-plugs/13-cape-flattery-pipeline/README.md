# Routing and plugs · 13 · Cape Flattery pipeline

Keeper Chenoa stands Cape Flattery on Makah land. The cape board is an
outer pipeline. Tatoosh Island is `forward/2`ed behind ticket
`tatoosh-clear`. Without it, the lookout plug halts at 403 after the cape
plug has already stamped. With it, nested `resources` list Nessa's and
Corin's watches. The fog glass is a more specific route declared before
`resources`, so `/watches/fog` is not swallowed as an `:id`.

**What it teaches**

- Capstone: outer pipeline, `forward/2`, `halt/1`, nested scopes, and
  `resources/4` on one headland.
- Parent pipelines run before a forwarded router. The cape stamp is on
  the denied lookout page.
- A specific `get` declared before `resources` wins over `:id`.
- Nested path params (`keeper`, `id`) stay strings.

**Files**

| File | Role |
| --- | --- |
| [`pipeline_live.ex`](pipeline_live.ex) | Catalog page |
| [`cape_plug.ex`](cape_plug.ex) | Outer pipeline plug |
| [`lookout_plug.ex`](lookout_plug.ex) | Inner halt on a missing ticket |
| [`lookout_router.ex`](lookout_router.ex) | Forwarded router, fog route, resources |
| [`pipeline_controller.ex`](pipeline_controller.ex) | Outer cape board |
| [`lookout_controller.ex`](lookout_controller.ex) | Desk and fog glass |
| [`watch_controller.ex`](watch_controller.ex) | Nested watches |
| [`pipeline_test.exs`](pipeline_test.exs) | Cape, halt, forward, resources, fog |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/13-cape-flattery-pipeline](http://localhost:4000/features/01-routing-and-plugs/13-cape-flattery-pipeline).

```sh
mix test features/01-routing-and-plugs/13-cape-flattery-pipeline/pipeline_test.exs
```
