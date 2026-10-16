# Routing and plugs · 06 · Changi hydrant tape

Operator Siti reads the fuel tape at Changi hydrant pit 12 on
taxiway N. A pipeline plug assigns the shift (`day`, `swing`, or
`graveyard`) onto the conn. The controller tape prints that assign as-is.
The same LiveView mounted on the catalog path has no pipeline plug, so
`assign_new(:shift, ...)` falls back to "no shift from the plug". A
disconnected GET of `/hydrant` copies the plug's shift. The connected mount
runs the fallback again: pipeline plugs do not run on the socket, and
`assign_new/3` does not keep the conn value after connect. Night shift is
lost after `live/2`.

**What it teaches**

- Router pipeline assigns are on the conn when a controller renders.
- They are not already keys on the LiveView socket.
- `assign_new/3` copies a conn assign on the disconnected HTTP render.
- The connected mount runs the fallback. A shift stamped by a plug does
  not survive into the LiveView process.

**Files**

| File | Role |
| --- | --- |
| [`hydrant_tape_live.ex`](hydrant_tape_live.ex) | Catalog map and the `/hydrant` LiveView |
| [`hydrant_plug.ex`](hydrant_plug.ex) | Pipeline plug that assigns shift and hydrant |
| [`hydrant_tape_controller.ex`](hydrant_tape_controller.ex) | Tape that reads conn.assigns directly |
| [`hydrant_tape_html.ex`](hydrant_tape_html.ex) | The controller tape |
| [`hydrant_tape_test.exs`](hydrant_tape_test.exs) | Controller vs catalog vs hydrant |

**Try it**

```sh
mix phx.server
```

Open
[/features/01-routing-and-plugs/06-changi-hydrant-tape](http://localhost:4000/features/01-routing-and-plugs/06-changi-hydrant-tape),
then the controller tape and the LiveView hydrant.

```sh
mix test features/01-routing-and-plugs/06-changi-hydrant-tape/hydrant_tape_test.exs
```
