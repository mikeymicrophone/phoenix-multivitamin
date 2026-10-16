# Client hooks · 10 · Taipei Songshan stylus

Maintenance recorder Mei-ling checks a pressure-sensitive stylus before signing the ATR 72-600 trim card at Songshan.

**What it teaches**

- `ResizeObserver` sizes a native canvas widget; `AbortController` and disconnect clean up browser resources.
- A bounded list payload is folded with `Enum.reduce_while/3`, rejecting an entire malformed stroke.
- Pointer pressure and a keyboard-accessible calibration button share one reply contract.

**Files**

| File | Role |
| --- | --- |
| [`songshan_stylus_live.ex`](songshan_stylus_live.ex) | LiveView and colocated hook |
| [`songshan_stylus_live_test.exs`](songshan_stylus_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/10-taipei-songshan-stylus](http://localhost:4000/features/13-client-hooks/10-taipei-songshan-stylus).

Draw a pressure stroke or use the calibration button. Resize the window, then leave the
page to tear down the observer and pointer listeners.

```sh
mix test features/13-client-hooks/10-taipei-songshan-stylus/songshan_stylus_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
