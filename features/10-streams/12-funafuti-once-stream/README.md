# Streams · 12 · Funafuti once stream

Clerk Talia lists DHC-2 Beaver hops at Funafuti once. The count is an assign, not a second walk of the stream.

**What it teaches**

- A stream may be consumed once per render.
- Counts live in a separate assign.

**Files**

| File | Role |
| --- | --- |
| [`once_stream_live.ex`](once_stream_live.ex) | hop_count assign |
| [`once_stream_live_test.exs`](once_stream_live_test.exs) | Count tracks the insert |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/12-funafuti-once-stream](http://localhost:4000/features/10-streams/12-funafuti-once-stream).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/12-funafuti-once-stream/once_stream_live_test.exs
```
