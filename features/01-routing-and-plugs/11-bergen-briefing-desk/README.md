# Routing and plugs · 11 · Bergen briefing desk

Dispatcher Åse keeps the Flesland SID plates at Bergen Flesland.
The roster is public. The briefing desk plug reads
`:briefing_dispatcher` from the session. Missing that key, it `redirect/2`s to
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
| [`briefing_desk_live.ex`](briefing_desk_live.ex) | Catalog page |
| [`briefing_desk_controller.ex`](briefing_desk_controller.ex) | Roster, halted desk, leaky desk |
| [`briefing_desk_html.ex`](briefing_desk_html.ex) | Roster and the open drawer |
| [`briefing_desk_test.exs`](briefing_desk_test.exs) | Redirect, session, AlreadySentError |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/11-bergen-briefing-desk](http://localhost:4000/features/01-routing-and-plugs/11-bergen-briefing-desk).

```sh
mix test features/01-routing-and-plugs/11-bergen-briefing-desk/briefing_desk_test.exs
```
