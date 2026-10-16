# Routing and plugs · 01 · Lukla shear gate

Controller Tashi watches the shear gate at Tenzing–Hillary, where the Khumbu
approach funnels a Dornier 228 past Nupla. The paper map is a LiveView. The
working gate is a controller: a router pipeline plug names the approach, then
two function plugs on the controller stamp the shear window and the HTTP
method before `show/2` draws the inbound board.

**What it teaches**

- A router `pipeline` plug runs after the route matches and before the
  controller.
- Function plugs declared with `plug :stamp_shear_window` on the controller
  run next, still before the action.
- Assigns those plugs write are on the conn when `show/2` renders.

**Files**

| File | Role |
| --- | --- |
| [`shear_gate_live.ex`](shear_gate_live.ex) | Catalog page and the link onto the approach |
| [`shear_gate_plug.ex`](shear_gate_plug.ex) | Router pipeline plug that names the approach |
| [`shear_gate_controller.ex`](shear_gate_controller.ex) | Function plugs, then the board action |
| [`shear_gate_html.ex`](shear_gate_html.ex) | The inbound board |
| [`shear_gate_test.exs`](shear_gate_test.exs) | Asserts plug order on the rendered board |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/01-lukla-shear-gate](http://localhost:4000/features/01-routing-and-plugs/01-lukla-shear-gate)
and follow the approach.

```sh
mix test features/01-routing-and-plugs/01-lukla-shear-gate/shear_gate_test.exs
```
