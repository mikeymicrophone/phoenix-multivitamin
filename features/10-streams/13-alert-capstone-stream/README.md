# Streams · 13 · Alert capstone stream

Clerk Neevee inserts, deletes, and resets Airbus A400M aprons at Alert.

**What it teaches**

- Capstone: insert, delete, reset, and an empty apron.

**Files**

| File | Role |
| --- | --- |
| [`capstone_stream_live.ex`](capstone_stream_live.ex) | Insert, delete, reset |
| [`capstone_stream_live_test.exs`](capstone_stream_live_test.exs) | Lincoln in, Alert out, then empty |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/13-alert-capstone-stream](http://localhost:4000/features/10-streams/13-alert-capstone-stream).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/13-alert-capstone-stream/capstone_stream_live_test.exs
```
