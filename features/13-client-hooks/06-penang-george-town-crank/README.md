# Client hooks · 06 · Penang George Town crank

Ground chief Faridah checks two towbar cranks for the Boeing 737-800; each tug keeps its own ratchet position.

**What it teaches**

- `pushEventTo` targets a LiveComponent root by selector and replies to that hook alone.
- `Map.fetch/2` and cond distinguish an unknown direction, a ratchet stop, and an accepted turn.

**Files**

| File | Role |
| --- | --- |
| [`george_town_crank_live.ex`](george_town_crank_live.ex) | LiveView and colocated hook |
| [`george_town_crank_live_test.exs`](george_town_crank_live_test.exs) | Hook contract and server behavior |
| [`towbar_cell.ex`](towbar_cell.ex) | Component-owned ratchet and targeted colocated hook |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/06-penang-george-town-crank](http://localhost:4000/features/13-client-hooks/06-penang-george-town-crank).

Tighten the north tug and release the south tug at its stop. Each crank replies
independently; neither can pass its ratchet limits.

```sh
mix test features/13-client-hooks/06-penang-george-town-crank/george_town_crank_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
