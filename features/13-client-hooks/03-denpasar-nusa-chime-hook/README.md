# Client hooks · 03 · Denpasar Nusa chime hook

Gate agent Ayu rehearses a Nusa Penida boarding chime for the DHC-6 Twin Otter, then packs the bell away.

**What it teaches**

- `JS.dispatch/2` reaches a window listener that is removed by `destroyed()`.
- Conditional hook removal and remounting avoid accumulating global listeners.
- Numeric hook payloads match guarded function heads instead of phx-value strings.

**Files**

| File | Role |
| --- | --- |
| [`chime_hook_live.ex`](chime_hook_live.ex) | LiveView and colocated hook |
| [`chime_hook_live_test.exs`](chime_hook_live_test.exs) | Hook contract and server behavior |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/13-client-hooks/03-denpasar-nusa-chime-hook](http://localhost:4000/features/13-client-hooks/03-denpasar-nusa-chime-hook).

Rehearse two strikes, pack the bell, then unpack it and rehearse again. A single call
should count two strikes each time.

```sh
mix test features/13-client-hooks/03-denpasar-nusa-chime-hook/chime_hook_live_test.exs
```

LiveViewTest checks markup and server events; it does not execute JavaScript.
Use the browser to exercise the hook's drawing, listeners, and cleanup.
