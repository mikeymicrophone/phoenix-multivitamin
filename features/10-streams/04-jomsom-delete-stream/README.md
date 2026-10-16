# Streams · 04 · Jomsom delete stream

Clerk Dorje pulls a finished Cessna 206 Stationair Mustang leg off the Jomsom board.

**What it teaches**

- `stream_delete_by_dom_id/3` removes a finished row without fetching its record.
- `phx-value-dom_id` sends the computed row ID; binary matching and a guard restrict it to the known legs.

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
