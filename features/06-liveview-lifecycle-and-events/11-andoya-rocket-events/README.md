# LiveView lifecycle and events · 11 · Andøya rocket events

Range tech Eirik arms the ALV stack at Andøya Space. The connected mount
pushes `arm_stack` to a colocated hook. Each pulse pushes `sound_stack`. A
hook can also ask `stack_status` and get a `{:reply, map, socket}`.

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
| [`rocket_events_live.ex`](rocket_events_live.ex) | The LiveView: push_event, reply, and the colocated stack console |
| [`rocket_events_live_test.exs`](rocket_events_live_test.exs) | LiveViewTest for push events and the hook reply |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/11-andoya-rocket-events](http://localhost:4000/features/06-liveview-lifecycle-and-events/11-andoya-rocket-events).
Fire two pulses. The console should show the push.

```sh
mix test features/06-liveview-lifecycle-and-events/11-andoya-rocket-events/rocket_events_live_test.exs
```
