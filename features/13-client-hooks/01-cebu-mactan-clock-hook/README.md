# Client hooks · 01 · Cebu Mactan clock hook

Dispatcher Luningning compares the Mactan departure clock with UTC before releasing the ATR 72-600.

**What it teaches**

- `mounted()` formats two clocks with `Intl.DateTimeFormat` and dataset time zones.
- `destroyed()` clears the browser interval; static HTML remains useful before connection.

**Files**

| File | Role |
| --- | --- |
| [`clock_hook_live.ex`](clock_hook_live.ex) | LiveView and colocated hook |
| [`clock_hook_live_test.exs`](clock_hook_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/01-cebu-mactan-clock-hook](http://localhost:4000/features/13-client-hooks/01-cebu-mactan-clock-hook).

Compare the Mactan and UTC clocks, then navigate back to the catalog to tear down both
intervals.

```sh
mix test features/13-client-hooks/01-cebu-mactan-clock-hook/clock_hook_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
