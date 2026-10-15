# Routing and plugs · 07 · Colman Dock shed

Agent Priya works the walk-on shed at Colman Dock for the Seattle–Bainbridge
run of the Wenatchee. Three controller plugs run in order: stamp the dock,
check the ferry pass, stamp the turnstile. Without pass `wenatchee-walk-on`,
`check_ferry_pass/2` renders 403 and `halt/1`. The turnstile plug never
stamps, and `show/2` never posts the slip. With the pass, the whole stack
finishes.

**What it teaches**

- `halt/1` in a controller plug skips later plugs and the action.
- Plugs that already ran keep their assigns. The denied page still names
  Colman Dock.
- A valid pass lets every later plug, and `show/2`, run.

**Files**

| File | Role |
| --- | --- |
| [`dock_shed_live.ex`](dock_shed_live.ex) | Catalog page |
| [`dock_shed_controller.ex`](dock_shed_controller.ex) | Three function plugs and the shed action |
| [`dock_shed_html.ex`](dock_shed_html.ex) | Admitted board and the denied gate |
| [`dock_shed_test.exs`](dock_shed_test.exs) | Trace with and without a pass |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/07-colman-dock-shed](http://localhost:4000/features/01-routing-and-plugs/07-colman-dock-shed).

```sh
mix test features/01-routing-and-plugs/07-colman-dock-shed/dock_shed_test.exs
```
