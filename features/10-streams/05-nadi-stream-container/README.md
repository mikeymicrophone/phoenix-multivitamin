# Streams · 05 · Nadi stream container

Clerk Litia streams Boeing 737-800 slots at Nadi. The parent owns phx-update="stream".

**What it teaches**

- The container has `id` and `phx-update="stream"`.

**Files**

| File | Role |
| --- | --- |
| [`stream_container_live.ex`](stream_container_live.ex) | Container plus insert |
| [`stream_container_live_test.exs`](stream_container_live_test.exs) | Momi joins Nadi west |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/05-nadi-stream-container](http://localhost:4000/features/10-streams/05-nadi-stream-container).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/05-nadi-stream-container/stream_container_live_test.exs
```
