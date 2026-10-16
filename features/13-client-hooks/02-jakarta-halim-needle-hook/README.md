# Client hooks · 02 · Jakarta Halim needle hook

Marshaller Ratih turns the CN-235 heading needle while the hook keeps its canvas between patches.

**What it teaches**

- `beforeUpdate()` snapshots the old bearing synchronously; `updated()` reads merged data attributes.
- `Integer.parse/1` and guarded result clauses reject partial or out-of-range bearings.

**Files**

| File | Role |
| --- | --- |
| [`needle_hook_live.ex`](needle_hook_live.ex) | LiveView and colocated hook |
| [`needle_hook_live_test.exs`](needle_hook_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/02-jakarta-halim-needle-hook](http://localhost:4000/features/13-client-hooks/02-jakarta-halim-needle-hook).

Face the east apron. The bearing readout and dataset change while the hook redraws its
retained canvas.

```sh
mix test features/13-client-hooks/02-jakarta-halim-needle-hook/needle_hook_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
