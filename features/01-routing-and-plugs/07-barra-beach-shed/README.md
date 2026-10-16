# Routing and plugs · 07 · Barra beach shed

Marshal Eilidh works the walk-on shed at Traigh Mhòr for the BN-2 Islander
on Barra's beach strip. Three controller plugs run in order: stamp the beach,
check the beach pass, stamp the turnstile. Without pass `islander-beach`,
`check_beach_pass/2` renders 403 and `halt/1`. The turnstile plug never
stamps, and `show/2` never posts the slip. With the pass, the whole stack
finishes.

**What it teaches**

- `halt/1` in a controller plug skips later plugs and the action.
- Plugs that already ran keep their assigns. The denied page still names
  Traigh Mhòr.
- A valid pass lets every later plug, and `show/2`, run.

**Files**

| File | Role |
| --- | --- |
| [`beach_shed_live.ex`](beach_shed_live.ex) | Catalog page |
| [`beach_shed_controller.ex`](beach_shed_controller.ex) | Three function plugs and the shed action |
| [`beach_shed_html.ex`](beach_shed_html.ex) | Admitted board and the denied gate |
| [`beach_shed_test.exs`](beach_shed_test.exs) | Trace with and without a pass |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/07-barra-beach-shed](http://localhost:4000/features/01-routing-and-plugs/07-barra-beach-shed).

```sh
mix test features/01-routing-and-plugs/07-barra-beach-shed/beach_shed_test.exs
```
