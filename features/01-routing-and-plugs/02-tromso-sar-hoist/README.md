# Routing and plugs · 02 · Tromsø SAR hoist

The Westland Sea King at the Tromsø SAR pad stays locked until a
request carries ticket `hoist-17`. Without it, a module plug in the router
pipeline renders the locked gate at 401 and calls `halt/1`. Winch operator Sigrid
never sees the request. With the ticket, the same plug assigns the pad and
the hoist, and `dispatch/2` slots the Sea King.

**What it teaches**

- A module plug in a router pipeline can refuse a request before the
  controller action.
- `halt/1` skips later plugs, including the dispatcher. The craft name from
  `dispatch/2` never appears on the locked page.
- The same plug assigns pad, hoist, and winch operator when the header is
  present.

**Files**

| File | Role |
| --- | --- |
| [`hoist_live.ex`](hoist_live.ex) | Catalog page for the pad |
| [`hoist_plug.ex`](hoist_plug.ex) | Module plug that checks `x-winch-ticket` |
| [`hoist_controller.ex`](hoist_controller.ex) | Dispatcher action, only reached with a ticket |
| [`hoist_html.ex`](hoist_html.ex) | Locked gate and the lift board |
| [`hoist_test.exs`](hoist_test.exs) | 401 without a ticket, 200 with hoist-17 |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/02-tromso-sar-hoist](http://localhost:4000/features/01-routing-and-plugs/02-tromso-sar-hoist)
then the pad. Without the header the Sea King winch stays locked.

```sh
mix test features/01-routing-and-plugs/02-tromso-sar-hoist/hoist_test.exs
```
