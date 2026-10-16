# Client hooks · 11 · Kaohsiung Love River scope

Rescue pilot Chia-chen arms the Love River training scope for the Bell 429 only after the flight desk connects.

**What it teaches**

- `connected?/1` chooses a static fallback or a mounted hook, with no browser side effects in the HTTP render.
- A mounted handshake registers `handleEvent` before requesting the first scope sweep.
- Socket-assign pattern matching and a channel whitelist reject an unrecognized scope.

**Files**

| File | Role |
| --- | --- |
| [`love_river_scope_live.ex`](love_river_scope_live.ex) | LiveView and colocated hook |
| [`love_river_scope_live_test.exs`](love_river_scope_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/11-kaohsiung-love-river-scope](http://localhost:4000/features/13-client-hooks/11-kaohsiung-love-river-scope).

Load the page with JavaScript disabled to see the static fallback. Re-enable it and
reconnect to arm the first training sweep.

```sh
mix test features/13-client-hooks/11-kaohsiung-love-river-scope/love_river_scope_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
