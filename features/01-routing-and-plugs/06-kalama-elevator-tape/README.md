# Routing and plugs · 06 · Kalama elevator tape

Operator Rhea reads the grain tape at the Kalama export elevator on the
Columbia. A pipeline plug assigns the shift (`day`, `swing`, or
`graveyard`) onto the conn. The controller tape prints that assign as-is.
The same LiveView mounted on the catalog path has no pipeline plug, so
`assign_new(:shift, ...)` falls back to "no shift from the plug". A
disconnected GET of `/silo` copies the plug's shift. The connected mount
runs the fallback again: pipeline plugs do not run on the socket, and
`assign_new/3` does not keep the conn value after connect.

**What it teaches**

- Router pipeline assigns are on the conn when a controller renders.
- They are not already keys on the LiveView socket.
- `assign_new/3` copies a conn assign on the disconnected HTTP render.
- The connected mount runs the fallback. A shift stamped by a plug does
  not survive into the LiveView process.

**Files**

| File | Role |
| --- | --- |
| [`elevator_tape_live.ex`](elevator_tape_live.ex) | Catalog map and the `/silo` LiveView |
| [`elevator_plug.ex`](elevator_plug.ex) | Pipeline plug that assigns shift and silo |
| [`elevator_tape_controller.ex`](elevator_tape_controller.ex) | Tape that reads conn.assigns directly |
| [`elevator_tape_html.ex`](elevator_tape_html.ex) | The controller tape |
| [`elevator_tape_test.exs`](elevator_tape_test.exs) | Controller vs catalog vs silo |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/06-kalama-elevator-tape](http://localhost:4000/features/01-routing-and-plugs/06-kalama-elevator-tape),
then the controller tape and the LiveView silo.

```sh
mix test features/01-routing-and-plugs/06-kalama-elevator-tape/elevator_tape_test.exs
```
