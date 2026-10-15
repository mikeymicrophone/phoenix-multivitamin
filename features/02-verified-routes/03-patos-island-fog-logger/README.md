# Verified routes · 03 · Patos Island fog logger

Orrin keeps the dawn watch and Tamsin the dusk watch at Patos Island Light,
the northern light of the San Juans. Each watch card interpolates into
`~p".../watches/#{watch}"` through `Phoenix.Param`.

**What it teaches**

- Interpolated segments call `Phoenix.Param.to_param/1`, then URI-encode.
  `@derive {Phoenix.Param, key: :slug}` lets the struct drop in as `#{watch}`.
- A map is not a struct. Interpolating `%{slug: "dawn"}` raises
  `ArgumentError`.
- A space becomes `%20` in a path segment (`west%20bank`).
- A list of binaries joins with `/` at runtime, so one interpolation can
  emit extra segments the compile-time check never saw.

**Files**

| File | Role |
| --- | --- |
| [`patos_island_watch.ex`](patos_island_watch.ex) | Watch struct with `Phoenix.Param` derive |
| [`fog_logger_live.ex`](fog_logger_live.ex) | The LiveView: dawn and dusk verified paths |
| [`fog_logger_live_test.exs`](fog_logger_live_test.exs) | Struct, map, list, and navigation |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/03-patos-island-fog-logger](http://localhost:4000/features/02-verified-routes/03-patos-island-fog-logger).
Switch to dusk watch.

```sh
mix test features/02-verified-routes/03-patos-island-fog-logger/fog_logger_live_test.exs
```
