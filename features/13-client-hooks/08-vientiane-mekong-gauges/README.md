# Client hooks · 08 · Vientiane Mekong gauges

Weather observer Khamla refreshes Wattay pressure and rain gauges for the Lao Airlines ATR 72 after a socket interruption.

**What it teaches**

- `disconnected()` marks stale gauges; `reconnected()` requests an authoritative snapshot.
- A mounted handshake avoids relying on an event sent before the hook is listening.
- `Enum.reduce/3` turns station tuples into the same reply and push-event payload.

**Files**

| File | Role |
| --- | --- |
| [`mekong_gauges_live.ex`](mekong_gauges_live.ex) | LiveView and colocated hook |
| [`mekong_gauges_live_test.exs`](mekong_gauges_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/08-vientiane-mekong-gauges](http://localhost:4000/features/13-client-hooks/08-vientiane-mekong-gauges).

Post monsoon readings, then disconnect and reconnect with the console commands in the
feature README. The stale indicator clears with the latest station snapshot.

```sh
mix test features/13-client-hooks/08-vientiane-mekong-gauges/mekong_gauges_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
