# Streams · 06 · Inuvik map rows

Clerk Qajaq streams DHC-4 Caribou METARs that are maps, not schemas. The DOM id comes from the hour.

**What it teaches**

- `stream_configure/3` sets `dom_id` for a row that is not a schema.

**Files**

| File | Role |
| --- | --- |
| [`map_rows_live.ex`](map_rows_live.ex) | dom_id from hour |
| [`map_rows_live_test.exs`](map_rows_live_test.exs) | metar-18z and metar-21z |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/06-inuvik-map-rows](http://localhost:4000/features/10-streams/06-inuvik-map-rows).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/06-inuvik-map-rows/map_rows_live_test.exs
```
