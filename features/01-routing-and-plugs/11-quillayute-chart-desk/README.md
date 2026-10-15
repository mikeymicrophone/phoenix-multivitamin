# Routing and plugs · 11 · Quillayute chart desk

Officer Wren keeps the La Push bar charts at the Quillayute River Coast
Guard Station. The roster is public. The chart desk plug reads
`:chart_officer` from the session. Missing that key, it `redirect/2`s to
the roster and `halt/1`s, so the drawer never opens. The leaky desk
redirects without `halt/1`: `redirect/2` has already sent 302, and the
action still runs, raising `Plug.Conn.AlreadySentError`.

**What it teaches**

- A controller plug can read the session and redirect before the action.
- `redirect/2` sends the response immediately. It does not halt the
  pipeline.
- `halt/1` after the redirect is what keeps later plugs and the action
  from running.

**Files**

| File | Role |
| --- | --- |
| [`chart_desk_live.ex`](chart_desk_live.ex) | Catalog page |
| [`chart_desk_controller.ex`](chart_desk_controller.ex) | Roster, halted desk, leaky desk |
| [`chart_desk_html.ex`](chart_desk_html.ex) | Roster and the open drawer |
| [`chart_desk_test.exs`](chart_desk_test.exs) | Redirect, session, AlreadySentError |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/11-quillayute-chart-desk](http://localhost:4000/features/01-routing-and-plugs/11-quillayute-chart-desk).

```sh
mix test features/01-routing-and-plugs/11-quillayute-chart-desk/chart_desk_test.exs
```
