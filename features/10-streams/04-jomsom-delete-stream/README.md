# Streams · 04 · Jomsom delete stream

Clerk Dorje pulls a finished Cessna 206 Stationair Mustang leg off the Jomsom board.

**What it teaches**

- `stream_delete/3` removes a finished row.

**Files**

| File | Role |
| --- | --- |
| [`delete_stream_live.ex`](delete_stream_live.ex) | Finish Mustang |
| [`delete_stream_live_test.exs`](delete_stream_live_test.exs) | Mustang leaves; Kali stays |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/04-jomsom-delete-stream](http://localhost:4000/features/10-streams/04-jomsom-delete-stream).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/04-jomsom-delete-stream/delete_stream_live_test.exs
```
