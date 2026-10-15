# Routing and plugs · 04 · Neah Bay entrance log

Recorder Chenoa keeps the canoe log at the Neah Bay entrance, where Makah
hulls come back in from the Strait of Juan de Fuca. The catalog page lives
on the main router. The working log is `forward/2`ed into its own
`Phoenix.Router`, whose routes are `/` and `/canoe/:hull`.

**What it teaches**

- `forward/2` strips the prefix off `path_info` and appends it to
  `script_name`. The inner router is not aware of `/features/.../entrance`.
- `request_path` still names the full URL the browser asked for.
- Parent pipelines (`:browser`) run before the forwarded router.

**Files**

| File | Role |
| --- | --- |
| [`entrance_log_live.ex`](entrance_log_live.ex) | Catalog page |
| [`entrance_log_router.ex`](entrance_log_router.ex) | Forwarded router with `/` and `/canoe/:hull` |
| [`entrance_plug.ex`](entrance_plug.ex) | Stamps request_path, script_name, and path_info |
| [`entrance_log_controller.ex`](entrance_log_controller.ex) | The log and a named canoe |
| [`entrance_log_html.ex`](entrance_log_html.ex) | The board |
| [`entrance_log_test.exs`](entrance_log_test.exs) | Prefix vs remainder vs full path |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/04-neah-bay-entrance-log](http://localhost:4000/features/01-routing-and-plugs/04-neah-bay-entrance-log).

```sh
mix test features/01-routing-and-plugs/04-neah-bay-entrance-log/entrance_log_test.exs
```
