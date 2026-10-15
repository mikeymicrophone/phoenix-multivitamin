# Verified routes · 07 · Point No Point staff gate

Keeper Willa works the staff gate at Point No Point Light on the Kitsap
shore. Crew and tide are optional query keys. An empty or nil query drops
the `?`. A `false` relief flag stays on the URL.

**What it teaches**

- `~p"/gate?#{[]}"` and `~p"/gate?#{%{}}"` produce the bare path. The
  sigil omits `?` when the encoded query is `""`.
- `Plug.Conn.Query.encode/2` drops `nil` values, so
  `~p"/gate?#{[crew: nil, tide: "ebb"]}"` is `?tide=ebb`.
- `false` encodes as `"false"`. Optional-and-absent is `nil` or a missing
  key, not `false`.
- The same LiveView patches between those URLs. `handle_params/3` sees
  whichever keys survived encoding.

**Files**

| File | Role |
| --- | --- |
| [`staff_gate_live.ex`](staff_gate_live.ex) | The LiveView: bare, nil, false, and present queries |
| [`staff_gate_live_test.exs`](staff_gate_live_test.exs) | Encoding and the patches |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/07-point-no-point-staff-gate](http://localhost:4000/features/02-verified-routes/07-point-no-point-staff-gate).
Admit the relief boat, log ebb, then open the bare gate.

```sh
mix test features/02-verified-routes/07-point-no-point-staff-gate/staff_gate_live_test.exs
```
