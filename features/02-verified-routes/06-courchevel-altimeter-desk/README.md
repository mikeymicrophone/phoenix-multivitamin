# Verified routes · 06 · Courchevel altimeter desk

Yves keeps the evening altimeter desk at Courchevel for the Pilatus PC-12.
Odile takes midwatch. Patching the watch reuses the LiveView process.
Opening the altimeter cabinet `push_navigate`s to a second verified path
and mounts again.

**What it teaches**

- `push_patch(socket, to: ~p"...?#{[watch: "midwatch"]}")` stays on this
  socket. `handle_params/3` runs. Assigns such as cabinet clicks survive.
- `push_navigate(socket, to: ~p".../altimeter-cabinet")` is a new mount, even
  though the module is the same. Cabinet clicks reset.
- `<.link patch={~p}>` and `<.link navigate={~p}>` are those two motions
  as links. Both consume a verified path.
- `live_action` (`:cabinet` versus nil) tells the template which surface
  the route selected.

**Files**

| File | Role |
| --- | --- |
| [`altimeter_desk_live.ex`](altimeter_desk_live.ex) | Desk and altimeter cabinet on one LiveView |
| [`altimeter_desk_live_test.exs`](altimeter_desk_live_test.exs) | Patch versus navigate, clicks surviving |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/06-courchevel-altimeter-desk](http://localhost:4000/features/02-verified-routes/06-courchevel-altimeter-desk).
Log a click, patch midwatch, then open the cabinet.

```sh
mix test features/02-verified-routes/06-courchevel-altimeter-desk/altimeter_desk_live_test.exs
```
