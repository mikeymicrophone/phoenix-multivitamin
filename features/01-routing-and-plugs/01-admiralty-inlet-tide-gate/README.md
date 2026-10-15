# Routing and plugs · 01 · Admiralty Inlet tide gate

Keeper Maren watches the tide gate at Point Wilson, where Admiralty Inlet
funnels flood water past Partridge Bank. The paper map is a LiveView. The
working gate is a controller: a router pipeline plug names the inlet, then
two function plugs on the controller stamp the flood window and the HTTP
method before `show/2` draws the board.

**What it teaches**

- A router `pipeline` plug runs after the route matches and before the
  controller.
- Function plugs declared with `plug :stamp_gate_window` on the controller
  run next, still before the action.
- Assigns those plugs write are on the conn when `show/2` renders.

**Files**

| File | Role |
| --- | --- |
| [`tide_gate_live.ex`](tide_gate_live.ex) | Catalog page and the link onto the inlet |
| [`tide_gate_plug.ex`](tide_gate_plug.ex) | Router pipeline plug that names the inlet |
| [`tide_gate_controller.ex`](tide_gate_controller.ex) | Function plugs, then the board action |
| [`tide_gate_html.ex`](tide_gate_html.ex) | The tide board |
| [`tide_gate_test.exs`](tide_gate_test.exs) | Asserts plug order on the rendered board |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/01-admiralty-inlet-tide-gate](http://localhost:4000/features/01-routing-and-plugs/01-admiralty-inlet-tide-gate)
and follow the inlet.

```sh
mix test features/01-routing-and-plugs/01-admiralty-inlet-tide-gate/tide_gate_test.exs
```
