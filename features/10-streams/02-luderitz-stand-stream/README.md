# Streams · 02 · Lüderitz stand stream

Clerk Immanuel appends a Swearingen Metro III stand at Lüderitz.

**What it teaches**

- `stream_insert/4` appends a row.

**Files**

| File | Role |
| --- | --- |
| [`stand_stream_live.ex`](stand_stream_live.ex) | Append Kolmanskop |
| [`stand_stream_live_test.exs`](stand_stream_live_test.exs) | Kolmanskop appears after click |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/02-luderitz-stand-stream](http://localhost:4000/features/10-streams/02-luderitz-stand-stream).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/02-luderitz-stand-stream/stand_stream_live_test.exs
```
