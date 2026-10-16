# Verified routes · 03 · Ilulissat ice logger

Nivi keeps the dawn watch and Malik the dusk watch at the Ilulissat ice
logger, logging ice for the Bell 212 beside the icefjord. Each watch card
interpolates into `~p".../watches/#{watch}"` through `Phoenix.Param`.

**What it teaches**

- Interpolated segments call `Phoenix.Param.to_param/1`, then URI-encode.
  `@derive {Phoenix.Param, key: :slug}` lets the struct drop in as `#{watch}`.
- A map is not a struct. Interpolating `%{slug: "dawn"}` raises
  `ArgumentError`.
- A space becomes `%20` in a path segment (`ice%20fjord`).
- A list of binaries joins with `/` at runtime, so one interpolation can
  emit extra segments the compile-time check never saw.

**Files**

| File | Role |
| --- | --- |
| [`ilulissat_ice_watch.ex`](ilulissat_ice_watch.ex) | Watch struct with `Phoenix.Param` derive |
| [`ice_logger_live.ex`](ice_logger_live.ex) | The LiveView: dawn and dusk verified paths |
| [`ice_logger_live_test.exs`](ice_logger_live_test.exs) | Struct, map, list, and navigation |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/03-ilulissat-ice-logger](http://localhost:4000/features/02-verified-routes/03-ilulissat-ice-logger).
Switch to dusk watch.

```sh
mix test features/02-verified-routes/03-ilulissat-ice-logger/ice_logger_live_test.exs
```
