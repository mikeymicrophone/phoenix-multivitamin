# Verified routes · 08 · Smith Island tide drum

Keeper Calder winds the tide drum at Smith Island Light in the Strait of
Juan de Fuca. `~p` is a path. `url/1` hangs the endpoint host on it. A
`%URI{}` hangs the island's own host instead. The island-host action uses
`put_router_url/2` on the conn.

**What it teaches**

- `url(~p"/path")` reads the endpoint `url:` config. With only
  `host: "localhost"` it still emits port **4000** (Phoenix's default),
  not the test listener `http: [port: 4002]`.
- `url(%URI{scheme: "https", host: "tidedrum.smithisland.wa.gov", port: 443}, ~p"/path")`
  substitutes that host at runtime. Port 443 is omitted on https.
- `Phoenix.Controller.put_router_url/2` stores an override on the conn.
  `url(conn, ~p"/path")` then uses it. The path from `~p` is unchanged.
- `url/1` and `url/2` require a `~p` sigil, not a path string already
  produced. Use `unverified_url/2` if you only have a string.

**Files**

| File | Role |
| --- | --- |
| [`tide_drum_live.ex`](tide_drum_live.ex) | The LiveView: path, endpoint URL, island URL |
| [`tide_drum_controller.ex`](tide_drum_controller.ex) | Island-host action with `put_router_url/2` |
| [`tide_drum_live_test.exs`](tide_drum_live_test.exs) | Endpoint vs URI vs conn override |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/02-verified-routes/08-smith-island-tide-drum](http://localhost:4000/features/02-verified-routes/08-smith-island-tide-drum).
Compare the endpoint URL with the island URL. Fetch the island host.

```sh
mix test features/02-verified-routes/08-smith-island-tide-drum/tide_drum_live_test.exs
```
