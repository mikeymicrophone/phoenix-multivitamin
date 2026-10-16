# Client hooks · 12 · Busan Gwangalli waterfall

Radio technician Eun-ji compares air and ground training spectra before the H145 departs for a Gwangalli rescue drill.

**What it teaches**

- One colocated hook is reused by a function component with global attributes and a named slot with `:let`.
- `handleEvent` receives a shared event name but filters by instrument ID before drawing.
- A filter/sort/map pipeline converts frequency-strength tuples into a spectrum payload.

**Files**

| File | Role |
| --- | --- |
| [`gwangalli_waterfall_live.ex`](gwangalli_waterfall_live.ex) | LiveView and colocated hook |
| [`gwangalli_waterfall_live_test.exs`](gwangalli_waterfall_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/12-busan-gwangalli-waterfall](http://localhost:4000/features/13-client-hooks/12-busan-gwangalli-waterfall).

Scan each receiver. Both hooks hear the shared event name, but only the instrument
matching its scope ID paints a new waterfall row.

```sh
mix test features/13-client-hooks/12-busan-gwangalli-waterfall/gwangalli_waterfall_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
