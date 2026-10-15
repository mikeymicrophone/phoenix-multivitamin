# LiveView lifecycle and events · 11 · Marrowstone horn events

Keeper Linus sounds the Type F diaphone at Marrowstone Point Light, on the
Admiralty Inlet shore of Marrowstone Island. The connected mount pushes
`arm_horn` to a colocated hook. Each blast pushes `sound_horn`. A hook can
also ask `horn_status` and get a `{:reply, map, socket}`.

**What it teaches**

- `push_event/3` queues a client event. A colocated hook handles it with
  `this.handleEvent`.
- `push_event` during the disconnected HTTP render is discarded. The
  connected mount is a new process, so only `connected: true` is delivered.
- `{:reply, map, socket}` from `handle_event/3` answers a hook's
  `pushEvent`. LiveViewTest sees that with `assert_reply/2`.

**Files**

| File | Role |
| --- | --- |
| [`horn_events_live.ex`](horn_events_live.ex) | The LiveView: push_event, reply, and the colocated horn console |
| [`horn_events_live_test.exs`](horn_events_live_test.exs) | LiveViewTest for push events and the hook reply |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/11-marrowstone-horn-events](http://localhost:4000/features/06-liveview-lifecycle-and-events/11-marrowstone-horn-events).
Sound two blasts. The console should show the push.

```sh
mix test features/06-liveview-lifecycle-and-events/11-marrowstone-horn-events/horn_events_live_test.exs
```
