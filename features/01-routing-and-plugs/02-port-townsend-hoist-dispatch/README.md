# Routing and plugs · 02 · Port Townsend hoist dispatch

The Travelift at the Port Townsend Shipwrights Co-op stays locked until a
request carries ticket `hoist-17`. Without it, a module plug in the router
pipeline renders the locked gate at 401 and calls `halt/1`. Dispatcher Hollis
never sees the request. With the ticket, the same plug assigns the yard and
the hoist, and `dispatch/2` slots troller Marigold.

**What it teaches**

- A module plug in a router pipeline can refuse a request before the
  controller action.
- `halt/1` skips later plugs, including the dispatcher. The hull name from
  `dispatch/2` never appears on the locked page.
- The same plug assigns yard, hoist, and dispatcher when the header is
  present.

**Files**

| File | Role |
| --- | --- |
| [`hoist_live.ex`](hoist_live.ex) | Catalog page for the yard |
| [`hoist_plug.ex`](hoist_plug.ex) | Module plug that checks `x-boat-yard-ticket` |
| [`hoist_controller.ex`](hoist_controller.ex) | Dispatcher action, only reached with a ticket |
| [`hoist_html.ex`](hoist_html.ex) | Locked gate and the lift board |
| [`hoist_test.exs`](hoist_test.exs) | 401 without a ticket, 200 with hoist-17 |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/02-port-townsend-hoist-dispatch](http://localhost:4000/features/01-routing-and-plugs/02-port-townsend-hoist-dispatch)
then the yard. Without the header the Travelift stays locked.

```sh
mix test features/01-routing-and-plugs/02-port-townsend-hoist-dispatch/hoist_test.exs
```
