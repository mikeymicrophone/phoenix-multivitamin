# LiveView lifecycle and events · 08 · Keflavik jet-stream table

Observer Birkir logs the jet stream at Keflavik, for the Boeing 757 tracks.
The knot buttons use `phx-throttle="2000"`. LiveViewTest counts every
click. Patching the URL switches the reach without remounting.

**What it teaches**

- `phx-throttle="2000"` rate-limits repeated clicks in the browser: at most
  one event every two seconds while the button is mashed.
- `Phoenix.LiveViewTest.render_click/1` talks to the server directly. Two
  clicks in a row both count.
- `handle_params/3` still runs on a patch, so the Atlantic reach can change
  without losing the knots already posted.

**Files**

| File | Role |
| --- | --- |
| [`jetstream_table_live.ex`](jetstream_table_live.ex) | The LiveView: throttled clicks and reach switching |
| [`jetstream_table_live_test.exs`](jetstream_table_live_test.exs) | LiveViewTest proving render_click ignores throttle |

**Try it**

From the repository root, after `mix setup`:

```sh
mix phx.server
```

Open
[/features/06-liveview-lifecycle-and-events/08-keflavik-jetstream-table](http://localhost:4000/features/06-liveview-lifecycle-and-events/08-keflavik-jetstream-table).
Mash +1 kn; the browser should space the posts. Patch to the Atlantic reach.

```sh
mix test features/06-liveview-lifecycle-and-events/08-keflavik-jetstream-table/jetstream_table_live_test.exs
```
