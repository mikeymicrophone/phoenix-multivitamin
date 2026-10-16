# Client hooks · 04 · Yogyakarta Borobudur canvas

Tow planner Sekar marks a rendezvous along the Airbus A320 tow lane before the Borobudur charter departs.

**What it teaches**

- Pointer coordinates become a nested `pushEvent` payload; the reply paints the accepted tow point.
- `with` validates integer metres and a tow lane boundary, with explicit rejection replies.

**Files**

| File | Role |
| --- | --- |
| [`borobudur_canvas_live.ex`](borobudur_canvas_live.ex) | LiveView and colocated hook |
| [`borobudur_canvas_live_test.exs`](borobudur_canvas_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/04-yogyakarta-borobudur-canvas](http://localhost:4000/features/13-client-hooks/04-yogyakarta-borobudur-canvas).

Point along the lane, or use the midpoint button with the keyboard. The accepted
rendezvous appears on both the canvas and server readout.

```sh
mix test features/13-client-hooks/04-yogyakarta-borobudur-canvas/borobudur_canvas_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
