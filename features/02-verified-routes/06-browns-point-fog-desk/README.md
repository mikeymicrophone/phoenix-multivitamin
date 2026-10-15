# Verified routes · 06 · Browns Point fog desk

Pax keeps the evening fog desk at Browns Point Light on Commencement Bay.
Nola takes midwatch. Patching the watch reuses the LiveView process.
Opening the horn cabinet `push_navigate`s to a second verified path and
mounts again.

**What it teaches**

- `push_patch(socket, to: ~p"...?#{[watch: "midwatch"]}")` stays on this
  socket. `handle_params/3` runs. Assigns such as horn blasts survive.
- `push_navigate(socket, to: ~p".../horn-cabinet")` is a new mount, even
  though the module is the same. Horn blasts reset.
- `<.link patch={~p}>` and `<.link navigate={~p}>` are those two motions
  as links. Both consume a verified path.
- `live_action` (`:horn` versus nil) tells the template which surface
  the route selected.

**Files**

| File | Role |
| --- | --- |
| [`fog_desk_live.ex`](fog_desk_live.ex) | Desk and horn cabinet on one LiveView |
| [`fog_desk_live_test.exs`](fog_desk_live_test.exs) | Patch versus navigate, blasts surviving |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/06-browns-point-fog-desk](http://localhost:4000/features/02-verified-routes/06-browns-point-fog-desk).
Sound the horn, patch midwatch, then open the cabinet.

```sh
mix test features/02-verified-routes/06-browns-point-fog-desk/fog_desk_live_test.exs
```
