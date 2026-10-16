# Streams · 01 · Resolute departure stream

Clerk Aaluk keeps DHC-5 Buffalo departures at Resolute in a stream, not an assign list.

**What it teaches**

- `stream/4` replaces an assign list for the departure board.

**Files**

| File | Role |
| --- | --- |
| [`departure_stream_live.ex`](departure_stream_live.ex) | stream(:departures, ...) |
| [`departure_stream_live_test.exs`](departure_stream_live_test.exs) | Polaris is on the board |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/01-resolute-departure-stream](http://localhost:4000/features/10-streams/01-resolute-departure-stream).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/01-resolute-departure-stream/departure_stream_live_test.exs
```
