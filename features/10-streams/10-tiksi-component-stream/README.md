# Streams · 10 · Tiksi component stream

Clerk Aytal streams Kamov Ka-32 hoist cells at Tiksi.

**What it teaches**

- Each streamed row is a nested LiveComponent.

**Files**

| File | Role |
| --- | --- |
| [`hoist_cell.ex`](hoist_cell.ex) | Row component |
| [`component_stream_live.ex`](component_stream_live.ex) | Stream of cells |
| [`component_stream_live_test.exs`](component_stream_live_test.exs) | Laptev cell appears |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/10-streams/10-tiksi-component-stream](http://localhost:4000/features/10-streams/10-tiksi-component-stream).

Run the test with the rest of the bottle:

```sh
mix test features/10-streams/10-tiksi-component-stream/component_stream_live_test.exs
```
