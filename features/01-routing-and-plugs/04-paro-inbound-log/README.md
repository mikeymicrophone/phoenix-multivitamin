# Routing and plugs · 04 · Paro inbound log

Clerk Kinley keeps the A319 log in the Paro valley, where Drukair
airframes drop in over the Himalaya notch. The catalog page lives
on the main router. The working log is `forward/2`ed into its own
`Phoenix.Router`, whose routes are `/` and `/a319/:reg`.

**What it teaches**

- `forward/2` strips the prefix off `path_info` and appends it to
  `script_name`. The inner router is not aware of `/features/.../valley`.
- `request_path` still names the full URL the browser asked for.
- Parent pipelines (`:browser`) run before the forwarded router.

**Files**

| File | Role |
| --- | --- |
| [`inbound_log_live.ex`](inbound_log_live.ex) | Catalog page |
| [`inbound_log_router.ex`](inbound_log_router.ex) | Forwarded router with `/` and `/a319/:reg` |
| [`inbound_plug.ex`](inbound_plug.ex) | Stamps request_path, script_name, and path_info |
| [`inbound_log_controller.ex`](inbound_log_controller.ex) | The log and a named A319 |
| [`inbound_log_html.ex`](inbound_log_html.ex) | The board |
| [`inbound_log_test.exs`](inbound_log_test.exs) | Prefix vs remainder vs full path |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/04-paro-inbound-log](http://localhost:4000/features/01-routing-and-plugs/04-paro-inbound-log).

```sh
mix test features/01-routing-and-plugs/04-paro-inbound-log/inbound_log_test.exs
```
