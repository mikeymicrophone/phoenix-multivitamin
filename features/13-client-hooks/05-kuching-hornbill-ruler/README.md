# Client hooks · 05 · Kuching hornbill ruler

Loadmaster Dayang calibrates a wing-clearance ruler before the Dornier 228 enters the Kuching hangar.

**What it teaches**

- `push_event/3` delivers a ruler scale to `handleEvent`; its subscription is removed on destruction.
- `Map.fetch/2` selects a fleet span; a filtered comprehension builds metre ticks.

**Files**

| File | Role |
| --- | --- |
| [`hornbill_ruler_live.ex`](hornbill_ruler_live.ex) | LiveView and colocated hook |
| [`hornbill_ruler_live_test.exs`](hornbill_ruler_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/05-kuching-hornbill-ruler](http://localhost:4000/features/13-client-hooks/05-kuching-hornbill-ruler).

Choose each fleet span. The ruler receives a different scale and the server reports the
selected width.

```sh
mix test features/13-client-hooks/05-kuching-hornbill-ruler/hornbill_ruler_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
