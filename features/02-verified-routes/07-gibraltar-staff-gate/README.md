# Verified routes · 07 · Gibraltar staff gate

Guard Amira works the staff gate at Gibraltar on the North Front. Crew
and QNH are optional query keys. An empty or nil query drops the `?`. A
`false` relief flag stays on the URL.

**What it teaches**

- `~p"/gate?#{[]}"` and `~p"/gate?#{%{}}"` produce the bare path. The
  sigil omits `?` when the encoded query is `""`.
- `nil` does **not** drop the key. `~p"/gate?#{[crew: nil, qnh: "1013"]}"`
  is `?crew=&qnh=1013`. Leave the key out (`qnh: "1013"` only) to omit it.
- `false` encodes as `"false"`. Empty `crew=` arrives in params as `""`,
  which is truthy, so `value || "none"` will not treat it as missing.
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
[/features/02-verified-routes/07-gibraltar-staff-gate](http://localhost:4000/features/02-verified-routes/07-gibraltar-staff-gate).
Admit the relief van, log QNH, then open the bare gate.

```sh
mix test features/02-verified-routes/07-gibraltar-staff-gate/staff_gate_live_test.exs
```
