# LiveComponents · 07 · Samos stateless plate

Clerk Eleni stamps a Socata TBM 900 plate that only renders. LiveView still requires an id.

**What it teaches**

- A LiveComponent with only `render/1` is still identified by `id`.
- LiveView 1.2 does not allow a LiveComponent without `id`.

**Files**

| File | Role |
| --- | --- |
| [`stateless_plate.ex`](stateless_plate.ex) | render/1 only |
| [`stateless_plate_live.ex`](stateless_plate_live.ex) | Parent still passes id |
| [`stateless_plate_live_test.exs`](stateless_plate_live_test.exs) | The plate shows 1016 |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/11-live-components/07-samos-stateless-plate](http://localhost:4000/features/11-live-components/07-samos-stateless-plate).

Run the test with the rest of the bottle:

```sh
mix test features/11-live-components/07-samos-stateless-plate/stateless_plate_live_test.exs
```
