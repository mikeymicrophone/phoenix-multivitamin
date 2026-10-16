# Client hooks · 07 · Langkawi cable bells

Helicopter coordinator Suri sets the cable-car rescue bell cadence before the AW139 lifts toward the ridge.

**What it teaches**

- Dataset attributes carry a tuple-derived bell program into `mounted()` and `updated()`.
- A changed cadence restarts a browser interval; `destroyed()` clears it.
- Tuple matching and a guarded program lookup keep unlisted cadences off the instrument.

**Files**

| File | Role |
| --- | --- |
| [`cable_bells_live.ex`](cable_bells_live.ex) | LiveView and colocated hook |
| [`cable_bells_live_test.exs`](cable_bells_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/07-langkawi-cable-bells](http://localhost:4000/features/13-client-hooks/07-langkawi-cable-bells).

Switch between ridge and shore. The caption changes immediately and the browser replaces
the old cadence interval.

```sh
mix test features/13-client-hooks/07-langkawi-cable-bells/cable_bells_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
