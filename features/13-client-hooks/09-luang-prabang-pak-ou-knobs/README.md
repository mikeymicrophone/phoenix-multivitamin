# Client hooks · 09 · Luang Prabang Pak Ou knobs

Engineer Mali adjusts propeller inspection knobs for two Cessna 208 Caravan crews returning from the Pak Ou supply run.

**What it teaches**

- Stream rows have stable custom DOM IDs and individual ignored hook roots.
- stream_insert updates a row dataset; stream_delete_by_dom_id removes it and destroys its hook.
- Map.fetch and Map.pop reject missing aircraft without recreating a removed row.

**Files**

| File | Role |
| --- | --- |
| [`pak_ou_knobs_live.ex`](pak_ou_knobs_live.ex) | LiveView and colocated hook |
| [`pak_ou_knobs_live_test.exs`](pak_ou_knobs_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/09-luang-prabang-pak-ou-knobs](http://localhost:4000/features/13-client-hooks/09-luang-prabang-pak-ou-knobs).

Advance either inspection speed, then park that aircraft. Its row disappears and the
other knob continues to work.

```sh
mix test features/13-client-hooks/09-luang-prabang-pak-ou-knobs/pak_ou_knobs_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
