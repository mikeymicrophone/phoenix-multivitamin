# Verified routes · 10 · Addis ramp tickets

Ramp lead Selam issues stand tickets at the Addis Ababa Bole ramp for the
De Havilland Q400. The kiosk is a forwarded `Phoenix.Router`. Links from
the ramp board include the kiosk prefix in `~p`. Inside the kiosk,
`~p"/lane/2"` is unprefixed and `path(conn, ~p"/lane/2")` adds
`conn.script_name`.

**What it teaches**

- `forward "/.../kiosk", AddisRampKiosk` is verified from the main
  router as `~p"/.../kiosk/lane/2"` because the kiosk router defines
  `/lane/:lane`.
- A controller inside the forwarded router must `use Phoenix.VerifiedRoutes`
  with **that** router. Pointing it at the main router would warn on
  `~p"/lane/2"`.
- `~p"/lane/2"` generates `/lane/2`. `path(conn, ~p"/lane/2")` prepends
  the forward prefix stored in `script_name`.
- Catalog links live on the main router, so they write the prefix into
  the sigil. Forgetting it is a compile warning, not a quiet 404.

**Files**

| File | Role |
| --- | --- |
| [`ramp_tickets_live.ex`](ramp_tickets_live.ex) | Ramp board with prefixed ~p links |
| [`addis_ramp_kiosk.ex`](addis_ramp_kiosk.ex) | Forwarded Phoenix.Router |
| [`addis_ramp_lane_controller.ex`](addis_ramp_lane_controller.ex) | Lane window: local vs prefixed path |
| [`ramp_tickets_live_test.exs`](ramp_tickets_live_test.exs) | Prefix, script_name, and the board |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/10-addis-ramp-tickets](http://localhost:4000/features/02-verified-routes/10-addis-ramp-tickets).
Open lane 2. Compare the local kiosk path with the prefixed one.

```sh
mix test features/02-verified-routes/10-addis-ramp-tickets/ramp_tickets_live_test.exs
```
